import Foundation
import CoreData
import UIKit


class KletterfitDataController: ObservableObject {
    
    var container: NSPersistentContainer
    
    init(name: String) {
        container = NSPersistentContainer(name: name)
        container.loadPersistentStores(completionHandler: {_, error in
            if let error = error {
                print("Core Data error:\(error)")
            }
        })
    }
}
