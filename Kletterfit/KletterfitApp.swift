//
//  KletterfitApp.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 05.05.23.
//

import SwiftUI

@main
struct KletterfitApp: App {
    
    @StateObject private var DataController = KletterfitDataController(name: "Kletterfit")

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DataController.container.viewContext)
        }
    }
}

