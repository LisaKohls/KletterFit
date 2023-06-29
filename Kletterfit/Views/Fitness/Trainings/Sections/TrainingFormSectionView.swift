import SwiftUI

struct TrainingFormSectionView: View {
    @ObservedObject var viewModel: TrainingViewModel

    var body: some View {
        Section {
            TextField("Training Name", text: $viewModel.newTrainingName)
            TextField("Description", text: $viewModel.newTrainingDesc)

            Picker("Difficulty", selection: $viewModel.selectedDifficultyIndex) {
                ForEach(0..<viewModel.difficulties.count) { index in
                    Text(self.viewModel.difficulties[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Picker("Duration", selection: $viewModel.selectedDurationIndex) {
                ForEach(0..<viewModel.durations.count) { index in
                    Text("\(self.viewModel.durations[index]) minutes")
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}
