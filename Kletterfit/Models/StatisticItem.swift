import Foundation

struct StatisticItem: Identifiable{
    var id = UUID()
    var finishedTrainingDate: Date
    var finishedTrainingDuration: Int
    var finishedTrainingName: String
    var animate: Bool = false
}
