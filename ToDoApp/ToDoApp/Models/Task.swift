import Foundation
import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String = ""
    var dueDate: Date
    var isCompleted: Bool = false
    var priority: Priority = .medium
    var color: TaskColor = .blue
    
    enum Priority: Int, Codable, CaseIterable {
        case low = 0
        case medium = 1
        case high = 2
        
        var title: String {
            switch self {
            case .low: return "Low"
            case .medium: return "Medium"
            case .high: return "High"
            }
        }
        
        var icon: String {
            switch self {
            case .low: return "arrow.down"
            case .medium: return "minus"
            case .high: return "arrow.up"
            }
        }
    }
    
    enum TaskColor: String, Codable, CaseIterable {
        case red
        case orange
        case yellow
        case green
        case blue
        case purple
        case pink
        
        var color: Color {
            switch self {
            case .red: return .red
            case .orange: return .orange
            case .yellow: return .yellow
            case .green: return .green
            case .blue: return .blue
            case .purple: return .purple
            case .pink: return .pink
            }
        }
    }
}