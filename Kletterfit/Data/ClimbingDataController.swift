//
//  ClimbingDataController.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 08.06.23.
//

import Foundation
import CoreData
import UIKit


class ClimbingDataController: ObservableObject {
    
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
