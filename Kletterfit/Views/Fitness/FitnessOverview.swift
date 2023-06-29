import SwiftUI
import CoreData

struct ProgressInfo: Identifiable {
    var id: UUID = UUID()
    var title: String
    var value: Double
    var total: Double
}

struct FitnessOverview: View {
    
    @State var trainingItems: [TrainingItem] = [TrainingItem]()
    @State var currentWeekProgress: Double = 0
    
    @FetchRequest(
        entity: TrainingItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TrainingItem.name, ascending: true)]
    ) private var fetchedTrainingItems: FetchedResults<TrainingItem>
    
    @State private var onLoadAnimation: Bool = false
    
    var progressInfo: ProgressInfo {
            ProgressInfo(title: "Progress", value: currentWeekProgress, total: 1)
        }

    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 20.0) {
                        CircularProgressBar(title: progressInfo.title, value: progressInfo.value, total: progressInfo.total)
                            .frame(height: 140.0)
                            .padding(.top, 40)
                        
                    
                        NavigationLink(destination: FitnessStatisticsView(currentWeekProgress: $currentWeekProgress)) {
                            Text("See all statistics")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .padding(.top, 0)
                                .accessibility(identifier: "See all statistics")
                        }
                        .padding(.top, 8)
                        .opacity(onLoadAnimation ? 1 : 0)
                        .offset(y: onLoadAnimation ? 0 : 10)
                        .animation(.spring(response: 0.8, dampingFraction: 0.4).delay(0.3), value: onLoadAnimation)

                        HStack {
                            MainTabs(infoFitnessIcon: gradientButtonsInfo[1])
                                .opacity(onLoadAnimation ? 1 : 0)
                                .offset(x: onLoadAnimation ? 0 : -10, y: onLoadAnimation ? 0 : 5)
                                .animation(.easeInOut(duration: 0.5).delay(0.4), value: onLoadAnimation)
                            
                            Spacer()
                            
                            MainTabs(infoFitnessIcon: gradientButtonsInfo[2])
                                .opacity(onLoadAnimation ? 1 : 0)
                                .offset(x: onLoadAnimation ? 0 : 10, y: onLoadAnimation ? 0 : 5)
                                .animation(.easeInOut(duration: 0.5).delay(0.5), value: onLoadAnimation)
                        }
                        .padding(.top, 20)
                        
                        Text("Recently Trained")
                            .font(.headline)
                            .padding(.top, 16)
                            .opacity(onLoadAnimation ? 1 : 0)
                            .offset(x: onLoadAnimation ? 0 : -5)
                            .animation(.easeInOut(duration: 0.6).delay(0.5), value: onLoadAnimation)
                        
                        VStack(alignment: .leading, spacing: 8.0) {
                            ForEach(Array(fetchedTrainingItems.prefix(3).enumerated()), id: \.1.id) { index, item in
                                TrainingCard(item: item)
                                    .opacity(onLoadAnimation ? 1 : 0)
                                    .offset(y: onLoadAnimation ? 0 : 15)
                                    .animation(Animation.easeInOut(duration: 0.7).delay(0.6 + Double(index) * 0.1), value: onLoadAnimation)
                            }
                        }
                        .padding(.top, 4)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .onAppear {
                        withAnimation {
                            onLoadAnimation = true
                        }
                    }
                }
                .navigationTitle("Fitness Overview")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct FitnessOverview_Previews: PreviewProvider {
   
    static var previews: some View {
        FitnessOverview()
    }
}

