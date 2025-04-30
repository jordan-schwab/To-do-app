import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var sortOption: SortOption = .dueDate
    
    enum SortOption {
        case dueDate
        case priority
        case color
        case title
    }
    
    private let savePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.json")
    
    init() {
        loadTasks()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
        saveTasks()
    }
    
    func toggleCompletion(for task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    func sortedTasks() -> [Task] {
        switch sortOption {
        case .dueDate:
            return tasks.sorted { $0.dueDate < $1.dueDate }
        case .priority:
            return tasks.sorted { $0.priority.rawValue > $1.priority.rawValue }
        case .color:
            return tasks.sorted { $0.color.rawValue < $1.color.rawValue }
        case .title:
            return tasks.sorted { $0.title < $1.title }
        }
    }
    
    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Error saving tasks: \(error)")
        }
    }
    
    private func loadTasks() {
        do {
            guard let data = try? Data(contentsOf: savePath) else { return }
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Error loading tasks: \(error)")
            tasks = []
        }
    }
}