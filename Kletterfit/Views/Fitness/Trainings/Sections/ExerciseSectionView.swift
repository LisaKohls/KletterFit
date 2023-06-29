import SwiftUI
import CoreData

struct ExerciseSectionView: View {
    @ObservedObject var viewModel: TrainingViewModel
    var moc: NSManagedObjectContext

    var body: some View {
        Section(header: Text("Exercise")) {
            if viewModel.exercises.count != 0 {
                Picker(selection: $viewModel.selectedExerciseIndex, label: Text("Exercise")) {
                    ForEach(0..<viewModel.exercises.count, id: \.self) { index in
                        Text(viewModel.exercises[index].exerciseName ?? "Unnamed Exercise").tag(index)
                    }
                }
                
                Stepper(value: $viewModel.currentExerciseSets, in: 1...10) {
                    Text("Sets: \(viewModel.currentExerciseSets)")
                }
                
                Picker("Type", selection: $viewModel.exerciseTypeIndex) {
                    ForEach(0..<viewModel.exerciseTypes.count, id: \.self) { index in
                        Text(self.viewModel.exerciseTypes[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: viewModel.exerciseTypeIndex) { newValue in
                    viewModel.currentExerciseMeasure = newValue == 0 ? 8 : 30
                }
                
                if viewModel.exerciseTypeIndex == 0 {
                    Stepper(value: $viewModel.currentExerciseMeasure, in: 1...100) {
                        Text("Repetitions: \(viewModel.currentExerciseMeasure)")
                    }
                } else {
                    Stepper(value: $viewModel.currentExerciseMeasure, in: 5...300, step: 5) {
                        Text("Duration: \(viewModel.currentExerciseMeasure) seconds")
                    }
                }
                
                Button("Add Exercise") {
                    let exercise = ExerciseInTraining(context: moc)
                    exercise.name = viewModel.exercises[viewModel.selectedExerciseIndex].exerciseName
                    //exercise.difficulty = viewModel.exercises[viewModel.selectedExerciseIndex]
                       
                   // print("IM NOT", Int16(viewModel.currentExerciseSets))
                    exercise.id = UUID()
                    exercise.sets = Int16(viewModel.currentExerciseSets)
                    exercise.type = viewModel.exerciseTypes[viewModel.exerciseTypeIndex]
                    exercise.repetitions = Int16(viewModel.currentExerciseMeasure)
                    viewModel.newTrainingExercises.append(exercise)
                    viewModel.currentExerciseSets = 1
                    viewModel.currentExerciseMeasure = viewModel.exerciseTypeIndex == 0 ? 8 : 30
                }
            } else {
                Text("Please first go to 'Exercises' and add your personal exercises").foregroundColor(.red)
            }
        }.onAppear {
            viewModel.fetchExercises(context: self.moc)
        }
    }
}
