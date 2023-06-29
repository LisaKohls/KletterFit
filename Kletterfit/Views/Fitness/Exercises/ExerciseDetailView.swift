//
//  ExerciseDetailView.swift
//  Kletterfit
//
//  Created by Lisa Salzer on 14.06.23.
//

import SwiftUI

struct ExerciseDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.exerciseName)]) var exercises: FetchedResults<Exercises>
    
    var exercise: Exercises
    
    var body: some View {
        VStack{
            if let exerciseDescription = exercise.exerciseDescription, !exerciseDescription.isEmpty {
                HStack {
                    Text(exerciseDescription)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
            }
            Form {
                
                Section {
                    Text("Exercise Type")
                        .font(.headline)
                    Text(exercise.exerciseType ?? "none")
                    
                }
                
                Section {
                    Text("Muscle Group")
                        .font(.headline)
                    if let exerciseMuscleGroup = exercise.exerciseMuscleGroup, !exerciseMuscleGroup.isEmpty {
                        Text(exerciseMuscleGroup)
                        
                    } else {
                        Text("None")
                            .foregroundColor(.gray)
                    }
                    
                }
                Section {
                    if let exerciseTools = exercise.exerciseTools, !exerciseTools.isEmpty {
                        Text("Exercise Tools")
                            .font(.headline)
                        Text(exerciseTools)
                    }
                }
            }
            .navigationTitle(exercise.exerciseName ?? "")
        }
    }
}
