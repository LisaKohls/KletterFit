import SwiftUI
import CoreData

struct AddTrainingSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var showingSheet: Bool
    @ObservedObject var viewModel: TrainingViewModel
    var moc: NSManagedObjectContext
    
    var body: some View {
        NavigationView {
            Form {
                TrainingFormSectionView(viewModel: viewModel)
                AddedExercisesSectionView(viewModel: viewModel)
                ExerciseSectionView(viewModel: viewModel, moc: moc)
            }
            .navigationBarTitle("New Training", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                viewModel.reset()
                showingSheet = false
                moc.rollback()
            }, trailing: Button("Save") {
                if viewModel.save(viewContext: moc) {
                    showingSheet = false
                }
            })
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Invalid Training"), message: Text("Make sure you've filled out all necessary fields and added at least one exercise."), dismissButton: .default(Text("Got it!")))
            }
        }
    }
}
