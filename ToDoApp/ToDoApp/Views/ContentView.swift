import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var editingTask: Task?
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort By", selection: $viewModel.sortOption) {
                    Text("Due Date").tag(TaskViewModel.SortOption.dueDate)
                    Text("Priority").tag(TaskViewModel.SortOption.priority)
                    Text("Color").tag(TaskViewModel.SortOption.color)
                    Text("Title").tag(TaskViewModel.SortOption.title)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                List {
                    ForEach(viewModel.sortedTasks()) { task in
                        TaskRow(task: task)
                            .swipeActions {
                                Button(role: .destructive) {
                                    if let index = viewModel.tasks.firstIndex(where: { $0.id == task.id }) {
                                        viewModel.deleteTask(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    editingTask = task
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                                
                                Button {
                                    viewModel.toggleCompletion(for: task)
                                } label: {
                                    Label(task.isCompleted ? "Mark Incomplete" : "Mark Complete", 
                                          systemImage: task.isCompleted ? "xmark.circle" : "checkmark.circle")
                                }
                                .tint(.green)
                            }
                            .onTapGesture {
                                editingTask = task
                            }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddTask = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                TaskFormView(viewModel: viewModel, task: nil)
            }
            .sheet(item: $editingTask) { task in
                TaskFormView(viewModel: viewModel, task: task)
            }
        }
    }
}

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        HStack {
            Circle()
                .fill(task.color.color)
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                
                HStack {
                    Label(task.dueDate, format: .dateTime.day().month().year())
                        .font(.caption)
                    
                    Image(systemName: task.priority.icon)
                        .foregroundColor(priorityColor(task.priority))
                }
            }
            
            Spacer()
            
            if task.isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 4)
    }
    
    private func priorityColor(_ priority: Task.Priority) -> Color {
        switch priority {
        case .low: return .blue
        case .medium: return .orange
        case .high: return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}