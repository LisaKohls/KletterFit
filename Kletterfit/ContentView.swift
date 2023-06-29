//
//  ContentView.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 05.05.23.
//

import SwiftUI

struct ContentView: View {
   
    @FetchRequest(sortDescriptors: []) var progress: FetchedResults<Progress>
    
    var currentWeekProgress: Double {
           let lastProgress = progress.last
           return Double(lastProgress?.currentProgress ?? 0.0)
       }
    
    var body: some View {
        TabView {
            FitnessOverview(currentWeekProgress: currentWeekProgress)
                .tabItem {
                    Image(systemName: "figure.run")
                    Text("Fitness")
                }
            
            ClimbingOverView()
                .tabItem {
                    Image(systemName: "figure.climbing")
                    Text("Climbing")
                }
        }
    }
}

struct FitnessOverView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

