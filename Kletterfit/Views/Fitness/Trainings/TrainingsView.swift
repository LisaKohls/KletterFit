import SwiftUI
import CoreData

struct TrainingsView: View {
    
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        entity: TrainingItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TrainingItem.name, ascending: true)]
    ) private var trainingItems: FetchedResults<TrainingItem>
    
    @State var searchText = ""
    @State var showingSheet = false

    @StateObject var viewModel = TrainingViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 8.0) {
                    ForEach(trainingItems.filter({ $0.name?.lowercased().contains(searchText.lowercased()) ?? false || searchText.isEmpty })) { item in
                        TrainingCard(item: item)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle("Trainings", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            showingSheet = true
        }) {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $showingSheet) {
            AddTrainingSheetView(showingSheet: $showingSheet, viewModel: viewModel, moc: moc)
        }
    }
}
