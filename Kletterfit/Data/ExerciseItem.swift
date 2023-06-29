import Foundation
import SwiftUI

struct ExerciseItem: Identifiable {
    
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    let difficultyLevel: String
    let equipmentRequirements: String
    let targetedMuscleGroups: [String]
    let safetyConsiderations: String
    var progress: Int
    var isComplete: Bool
}
