import SwiftUI
import CoreData

class TrainingViewModel: ObservableObject {
    
    @Published var newTraining = TrainingItem(context: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
    @Published var currentExerciseSets = 1
    @Published var currentExerciseMeasure = 8
    @Published var selectedExerciseIndex = 0
    @Published var selectedDurationIndex = 0
    @Published var selectedDifficultyIndex = 0
    @Published var exerciseTypeIndex = 0
    @Published var newTrainingName: String = ""
    @Published var newTrainingDesc: String = ""
    @Published var newTrainingExercises: [ExerciseInTraining] = []
    @Published var showAlert: Bool = false
    @Published var exercises: [Exercises] = []
    
    let durations = Array(stride(from: 5, to: 185, by: 5))
    let difficulties = ["Easy", "Intermediate", "Hard"]
    let exerciseTypes = ["Repetitions", "Seconds"]
    let exerciseTimes = Array(stride(from: 5, to: 300, by: 5))
    
    func fetchExercises(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<Exercises> = Exercises.fetchRequest()
        
        do {
            let fetchedExercises = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.exercises = fetchedExercises
                if self.exercises.count > 0 {
                    self.selectedExerciseIndex = 0
                }
            }
        } catch let fetchErr {
            print("Failed to fetch Exercises:", fetchErr)
        }
    }
    
    var isSaveDisabled: Bool {
        newTrainingName.isEmpty || newTrainingDesc.isEmpty || newTrainingExercises.isEmpty
    }
    
    func save(viewContext: NSManagedObjectContext) -> Bool {
        if newTrainingName.isEmpty || newTrainingDesc.isEmpty || newTrainingExercises.isEmpty {
            showAlert = true
            return false;
        } else {
            let newTraining = TrainingItem(context: viewContext)
            newTraining.id = UUID()
            newTraining.name = newTrainingName
            newTraining.desc = newTrainingDesc
            newTraining.duration = "\(durations[selectedDurationIndex]) minutes"
            newTraining.difficulty = difficulties[selectedDifficultyIndex]
            
            newTrainingExercises.forEach { exercise in
                newTraining.addToExercises(exercise)
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            reset()
            showAlert = false
        }
        return true;
    }
    
    func reset() {
        newTrainingName = ""
        newTrainingDesc = ""
        newTrainingExercises.removeAll()
    }
}
