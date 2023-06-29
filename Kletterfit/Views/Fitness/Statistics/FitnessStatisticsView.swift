import SwiftUI
import Charts
import CoreData
import Foundation

struct FitnessStatisticsView: View {
    // MARK: - State Variables
    @State private var currentTab: String = "7 Days"
    @State private var isPopupVisible = false
    @State private var showingAlert = false
    @State private var weeklyGoal: Int = 0
    @State private var weekSpan: [StatisticItem] = []
    @State private var monthSpan: [StatisticItem] = []
    @State private var trainingData: [StatisticItem] = []
    
    @Binding var currentWeekProgress: Double
    @State private var completedTrainingsCountWeek: Int = 0
    
    // MARK: - Fetch Requests
    @FetchRequest(sortDescriptors: []) var trainingGoal: FetchedResults<TrainingGoal>
    @FetchRequest(sortDescriptors: []) var completedTraining: FetchedResults<CompletedTraining>
    @FetchRequest(sortDescriptors: []) var progress: FetchedResults<Progress>
    
    @Environment(\.managedObjectContext) private var moc
    
    // MARK: - Constants
    let yAxisDomain: ClosedRange<Double> = 0...12
    
    
    
    var body: some View {
        VStack(){
            progressBarsView
            Spacer()
            analyticsView
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Personal Statistics")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: goalButton)
        .onChange(of: currentTab) { updateAnalytics(for: $0); updateGoals()}
        .onAppear { updateGoals(); updateAnalytics(for: currentTab)
        }
    }
    
    @ViewBuilder
    private var progressBarsView: some View {
        HStack {
            CircularProgressBar(title: "Weekly Goal", value: currentWeekProgress, total: 1 )
        }
        .padding(20)
    }
    
    @ViewBuilder
    private var analyticsView: some View {
        VStack(alignment: .leading) {
            analyticsHeaderView
            AnimatedChartView
        }
    }
    
    @ViewBuilder
    private var analyticsHeaderView: some View {
        HStack {
            Text("Finished Trainings").fontWeight(.semibold)
        }
    }
    
    private let lastWeekStart = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
    
    
    @ViewBuilder
    private var AnimatedChartView: some View {
        GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 4) {
                ForEach(0..<7) { index in
                    let weekday = Calendar.current.date(byAdding: .day, value: index, to: lastWeekStart)!
                    let isTrainingDay = trainingData.contains { $0.finishedTrainingDate.isSameDay(as: weekday) }
                    
                    let barWidth = (geometry.size.width / 8) - 4
                    
                    let totalDuration = trainingData.reduce(0) { result, item in
                        if item.finishedTrainingDate.isSameDay(as: weekday) {
                            return result + item.finishedTrainingDuration
                        } else {
                            return result
                        }
                    }
                    
                    
                    let scale = CGFloat(Double(totalDuration) / yAxisDomain.upperBound)
                    
                    
                    Rectangle()
                        .fill(isTrainingDay ? Color.blue : Color.clear)
                        .frame(width: barWidth)
                        .scaleEffect(y: scale / 10, anchor: .bottom)
                        .animation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8), value: trainingData.first(where: { $0.finishedTrainingDate.isSameDay(as: weekday) })?.animate)
                        .overlay(
                            VStack {
                                Text(dayOfWeek(for: weekday))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        )
                }
            } .overlay(
                VStack() {
                    ForEach((0..<8).reversed(), id: \.self) { minute in
                        Text("\(minute * 20) min")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Spacer()
                    }
                }
                    .padding(.bottom, -30)
                    .padding(.trailing, -60)
                
            )
        }
        .frame(height: 300)
        .padding(.trailing, 20)
        .onAppear { animateGraph() }
    }
    
    private func dayOfWeek(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"  // Format for short weekday, e.g., "Mon"
        return dateFormatter.string(from: date)
    }
    
    
    
    private func updateGraph(){
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let filteredTrainingsWeek = completedTraining.filter { $0.finishedTrainingDate != nil && $0.finishedTrainingDate! > lastWeek  }
        
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
        let filteredTrainingsMonth = completedTraining.filter { $0.finishedTrainingDate != nil && $0.finishedTrainingDate! > lastMonth  }
        
        weekSpan = trainingsInTimespan(filteredTraining: filteredTrainingsWeek)
        monthSpan = trainingsInTimespan(filteredTraining: filteredTrainingsMonth)
        
    }
    
    private func trainingsInTimespan(filteredTraining: [CompletedTraining]) -> [StatisticItem]{
        var arrSpan: [StatisticItem] = []
        
        for training in filteredTraining {
            let statisticItem = StatisticItem(
                finishedTrainingDate: training.finishedTrainingDate!,
                finishedTrainingDuration: Int(training.finishedTrainingDuration),
                finishedTrainingName: training.finishedTrainingName!
            )
            arrSpan.append(statisticItem)
        }
        
        return arrSpan
        
    }
    
    private var goalButton: some View {
        Button("Add goal", action: { isPopupVisible = true })
            .popover(isPresented: $isPopupVisible, content: {
                goalPopoverView
            })
            .accessibility(identifier: "Add goal")
    }
    
    @ViewBuilder
    private var goalPopoverView: some View {
        VStack() {
            Text("Add your weekly exercise goal").bold()
            Text("How many times per week do you want to train?").padding()
            goalSelectionView
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private var goalSelectionView: some View {
        goalPicker(title: "Finished exercises per week", selection: $weeklyGoal, range: 1..<8).padding()
        goalSaveButton
    }
    
    private func goalPicker(title: String, selection: Binding<Int>, range: Range<Int>) -> some View {
        return Picker("Number of people", selection: selection) {
            ForEach(range) { Text("\($0) Exercises") }
        }
    }
    
    private var goalSaveButton: some View {
        Button("Add new goal") { saveNewGoal() }
            .alert("Successfully updated new goal", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    updateGoals()
                    isPopupVisible = false
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(0)
            .accessibility(identifier: "Add new goal")
    }
    
    
    private func updateAnalytics(for tab: String) {
        updateGraph()
        print("tab")
        if tab == "Month" {
            print("tab month")
            updateAnalyticsForMonth()
        } else if tab == "7 Days" {
            updateAnalyticsForWeek()
        }
    }
    
    private func updateAnalyticsForMonth() {
        trainingData = monthSpan
        for (index,_) in monthSpan.enumerated() {
            monthSpan[index].animate = false
        }
        animateGraph()
    }
    
    private func updateAnalyticsForWeek() {
        trainingData = weekSpan
        for (index,_) in weekSpan.enumerated() {
            weekSpan[index].animate = false
        }
        animateGraph()
    }
    
    
    private func updateGoals() {
        let count = countTrainingsLast7Days()
        
        //addCompleted()
        
        if let lastGoal = trainingGoal.last {
            weeklyGoal = Int(lastGoal.week)
            
            if(weeklyGoal + 1 <= count){
                print("goal reached")
                currentWeekProgress = 1
            }else{
                currentWeekProgress = calculateProgress(goal: Double(weeklyGoal), count: Double(count))
            }
        }
        
        print("weekly Goal: \(weeklyGoal + 1)")
        print("currentWeekProgress: \(currentWeekProgress)")
        print("Total trainings in the last 7 days: \(count)")
        saveProgress()
    }
    
    private func calculateProgress(goal: Double, count: Double) -> Double {
        
        if(goal + 1 <= count){
            print("goal is reached")
            return 1
        }
        
        let a = (goal + 1) * 0.1
        let b = count * 0.1
        let calc = b / a
        
        return calc
        
    }
    
    private func saveProgress() {
        print("progress saved: \(currentWeekProgress)")
        let newProgress = Progress(context: moc)
        newProgress.id = UUID()
        newProgress.currentProgress = Double(currentWeekProgress)
        try? moc.save()
    }
    
    private func saveNewGoal() {
        let newGoal = TrainingGoal(context: moc)
        newGoal.id = UUID()
        newGoal.week = Int16(weeklyGoal)
        try? moc.save()
        showingAlert = true
    }
    
    private func animateGraph() {
        for (index, _) in trainingData.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                withAnimation(.spring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8).delay(Double(index) * 0.05)) {
                    trainingData[index].animate = true
                }
            }
        }
    }
    
    
    func countTrainingsLast7Days() -> Int {
        let calendar = Calendar.current
        let startDate = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        let trainingsLast7Days = completedTraining.filter { training in
            if let date = training.finishedTrainingDate {
                return calendar.isDate(date, inSameDayAs: startDate) || date > startDate
            }
            return false
        }
        
        return trainingsLast7Days.count
    }
    
    
    func addCompleted() {
        let newGoal = CompletedTraining(context: moc)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        if let date = dateFormatter.date(from: "2023-06-16 15:02:55 +0000") {
            newGoal.finishedTrainingDate = date
            print("add \(date)")
        } else {
            print("Failed to parse the date.")
        }
        
        newGoal.id = UUID()
        
        newGoal.finishedTrainingName = "plank"
        newGoal.finishedTrainingDuration = 15
        
        try? moc.save()
        
    }
    
    
}

struct StatisticsView_Previews: PreviewProvider {
    @State static var currentWeekProgress: Double = 0
    static var previews: some View {
        FitnessStatisticsView(currentWeekProgress: $currentWeekProgress)
    }
}
