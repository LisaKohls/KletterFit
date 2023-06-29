import Foundation
import CoreData
import SwiftUI

class TrainingDetailViewModel: ObservableObject {
    
    func saveTrainingAsFinished(moc: NSManagedObjectContext, trainingItem: TrainingItem) {
        
        if let unwrappedString = trainingItem.duration {
            let characterSet = CharacterSet.decimalDigits.inverted
            let durationDigits = unwrappedString.components(separatedBy: characterSet).joined()

            if let durationInt = Int16(durationDigits) {
                // Use the durationInt variable (of type Int) for further processing
                print(durationInt) // Output: 50
                let finishedTraining = CompletedTraining(context: moc)
                finishedTraining.id = UUID()
                finishedTraining.finishedTrainingDate = Date()
                finishedTraining.finishedTrainingDuration = durationInt
                finishedTraining.finishedTrainingName = trainingItem.name ?? ""
                
                do {
                    try moc.save()
                } catch {
                    print("Error saving training: \(error)")
                }
            } else {
                // Handle the case where the string doesn't contain a valid integer
                print("Invalid duration format")
            }
        } else {
            // Handle the case where durationString is nil
            print("Duration string is nil")
        }
        
    }
}
