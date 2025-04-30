import SwiftUI

struct TaskFormView: View {
    @ObservedObject var viewModel: TaskViewModel
    let task: Task?
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority = Task.Priority.medium
    @State private var color = Task.TaskColor.blue
    @State private var isCompleted = false
    
    var isEditing: Bool {
        task != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $title)
                    
                    TextField("Description", text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Due Date")) {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section(header: Text("Priority")) {
                    Picker("Priority", selection: $priority) {
                        ForEach(Task.Priority.allCases, id: \.self) { priority in
                            Label(priority.title, systemImage: priority.icon)
                                .tag(priority)
                        }
                    }
                }
                
                Section(header: Text("Color")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(Task.TaskColor.allCases, id: \.self) { taskColor in
                                Circle()
                                    .fill(taskColor.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.primary, lineWidth: color == taskColor ? 2 : 0)
                                            .padding(-4)
                                    )
                                    .onTapGesture {
                                        color = taskColor
                                    }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                if isEditing {
                    Section {
                        Toggle("Completed", isOn: $isCompleted)
                    }
                }
            }
            .navigationTitle(isEditing ? "Edit Task" : "New Task")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Update" : "Add") {
                        if isEditing {
                            if var updatedTask = task {
                                updatedTask.title = title
                                updatedTask.description = description
                                updatedTask.dueDate = dueDate
                                updatedTask.priority = priority
                                updatedTask.color = color
                                updatedTask.isCompleted = isCompleted
                                viewModel.updateTask(updatedTask)
                            }
                        } else {
                            let newTask = Task(
                                title: title,
                                description: description,
                                dueDate: dueDate,
                                isCompleted: false,
                                priority: priority,
                                color: color
                            )
                            viewModel.addTask(newTask)
                        }
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
            .onAppear {
                if let task = task {
                    title = task.title
                    description = task.description
                    dueDate = task.dueDate
                    priority = task.priority
                    color = task.color
                    isCompleted = task.isCompleted
                }
            }
        }
    }
}