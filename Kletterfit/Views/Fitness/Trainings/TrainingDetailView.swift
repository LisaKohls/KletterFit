import SwiftUI

struct TrainingDetailView: View {
    @Binding var isPresented: Bool
    var trainingItem: TrainingItem
    
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel = TrainingDetailViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                List(trainingItem.exercises?.allObjects as? [ExerciseInTraining] ?? []) { exercise in
                    ExerciseRow(exercise: exercise)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .padding([.horizontal, .bottom])
                }
                .navigationTitle(trainingItem.name ?? "")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.isPresented = false
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.saveTrainingAsFinished(moc: self.moc, trainingItem: trainingItem)
                            self.isPresented = false
                        }) {
                            Text("Finished")
                        }
                    }
                }
            }
        }
    }
}
