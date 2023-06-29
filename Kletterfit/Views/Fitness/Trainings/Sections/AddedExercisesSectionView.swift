import SwiftUI

struct AddedExercisesSectionView: View {
    @ObservedObject var viewModel: TrainingViewModel

    var body: some View {
        if !viewModel.newTrainingExercises.isEmpty {
            Section(header: Text("Added Exercises")) {
                ForEach(viewModel.newTrainingExercises, id: \.id) { exercise in
                    HStack {
                        Text(exercise.name ?? "")
                        Spacer()
                        Text("\(exercise.sets) sets")
                        Text("|")
                        if exercise.type == "Repetitions" {
                            Text("\(exercise.repetitions) reps")
                        } else {
                            Text("\(exercise.repetitions) seconds")
                        }
                    }
                }
            }
        }
    }
}
