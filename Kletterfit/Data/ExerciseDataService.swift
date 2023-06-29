import Foundation
import SwiftUI

struct ExerciseDataService {
    
    func getExerciseData() -> [ExerciseItem] {
        let exercise1 = ExerciseItem(name: "Jumping Jacks",
                                     description: "Perform jumping jacks for 1 minute...",
                                     imageName: "figure.core.training",
                                     difficultyLevel: "Beginner",
                                     equipmentRequirements: "None",
                                     targetedMuscleGroups: ["Legs", "Cardio"],
                                     safetyConsiderations: "Avoid locking your knees...",
                                     progress: 0,
                                     isComplete: false)
        
        let exercise2 = ExerciseItem(name: "Push-ups",
                                     description: "Perform 10 push-ups...",
                                     imageName: "figure.core.training",
                                     difficultyLevel: "Intermediate",
                                     equipmentRequirements: "None",
                                     targetedMuscleGroups: ["Chest", "Arms"],
                                     safetyConsiderations: "Maintain a straight line...",
                                     progress: 0,
                                     isComplete: false)
        
        let exercise3 = ExerciseItem(name: "Squats",
                                     description: "Perform 15 squats...",
                                     imageName: "figure.core.training",
                                     difficultyLevel: "Beginner",
                                     equipmentRequirements: "None",
                                     targetedMuscleGroups: ["Legs", "Glutes"],
                                     safetyConsiderations: "Keep your knees aligned...",
                                     progress: 0,
                                     isComplete: false)
        
        let exercise4 = ExerciseItem(name: "Plank Hold",
                                     description: "Hold a plank position for 30 seconds...",
                                     imageName: "figure.core.training",
                                     difficultyLevel: "Intermediate",
                                     equipmentRequirements: "None",
                                     targetedMuscleGroups: ["Core", "Shoulders"],
                                     safetyConsiderations: "Engage your core muscles...",
                                     progress: 0,
                                     isComplete: false)
        
        let exercise5 = ExerciseItem(name: "Burpees",
                                     description: "Perform 8 burpees...",
                                     imageName: "figure.core.training",
                                     difficultyLevel: "Advanced",
                                     equipmentRequirements: "None",
                                     targetedMuscleGroups: ["Full Body", "Cardio"],
                                     safetyConsiderations: "Perform with controlled movements...",
                                     progress: 0,
                                     isComplete: false)
        
        return [exercise1, exercise2, exercise3, exercise4, exercise5]
    }
}
