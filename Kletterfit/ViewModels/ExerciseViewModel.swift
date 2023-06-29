import CoreData
import SwiftUI

class ExerciseViewModel: ObservableObject {
    @Published var exerciseName = ""
    @Published var exerciseDescription = ""
    @Published var exerciseTool = ""
    @Published var selectedMuscleGroups: Set<String> = []
    @Published var selectedExerciseType = "Strength"
    @Published var isMuscleGroupsExpanded = false
    @Published var isShowingNameError = false
    @Published var isShowingMuscleGroupsError = false

    func deleteExercise(moc: NSManagedObjectContext, id: UUID) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Exercises")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let exercises = try moc.fetch(fetchRequest)
            guard let exercise = exercises.first as? NSManagedObject else {
                return
            }
            
            moc.delete(exercise)
            try moc.save()
        } catch {
            print("Failed to delete exercise: \(error)")
        }
    }
    
    func addExercise(moc: NSManagedObjectContext) {
        let exercise = Exercises(context: moc)
        exercise.exerciseName = exerciseName
        exercise.exerciseDescription = exerciseDescription
        exercise.exerciseTools = exerciseTool
        exercise.exerciseType = selectedExerciseType
        exercise.exerciseMuscleGroup = selectedMuscleGroups.joined(separator: ", ")
        exercise.id = UUID()
        
        do {
            try moc.save()
        } catch {
            print("Failed to add exercise: \(error)")
        }
    }
}
