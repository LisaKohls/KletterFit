//
//  File.swift
//  Kletterfit
//
//  Created by Lisa Salzer on 14.06.23.
//

import SwiftUI
import CoreData

struct ExerciseOverView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject private var exerciseViewModel = ExerciseViewModel()
    @State private var isPresentingAddExerciseView = false
    @State private var searchText = ""
    @State private var selectedMuscleGroup = ""
    @State private var selectedExerciseType = ""
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Exercises.exerciseName, ascending: true)]) var exercises: FetchedResults<Exercises>
    
    var filteredExercises: [Exercises] {
        var filteredResults = Array(exercises)
        
        if !selectedExerciseType.isEmpty {
            filteredResults = filteredResults.filter { $0.exerciseType?.localizedCaseInsensitiveContains(selectedExerciseType) ?? false }
        }
        
        if !selectedMuscleGroup.isEmpty {
            filteredResults = filteredResults.filter { $0.exerciseMuscleGroup?.localizedCaseInsensitiveContains(selectedMuscleGroup) ?? false }
        }
        
        if !searchText.isEmpty {
            filteredResults = filteredResults.filter { $0.exerciseName?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
        
        return filteredResults
    }
    
    
    var body: some View {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        SearchBar(text: $searchText)
                            .padding(.top)
                        
                        Picker("Muscle Group", selection: $selectedMuscleGroup) {
                            Text("All").tag("")
                            Text("Abs").tag("Abs")
                            Text("Arms").tag("Arms")
                            Text("Back").tag("Back")
                            Text("Chest").tag("Chest")
                            Text("Glutes").tag("Glutes")
                            Text("Legs").tag("Legs")
                        }
                        .pickerStyle(.segmented)
                        .padding([.horizontal, .bottom])
                        
                        Picker("Exercise Type", selection: $selectedExerciseType) {
                            Text("All").tag("")
                            Text("Strength").tag("Strength")
                            Text("Cardio").tag("Cardio")
                        }
                        .pickerStyle(.segmented)
                        .padding([.horizontal, .bottom])
                        
                        
                        VStack(alignment: .center, spacing: 15.0) {
                            ForEach(filteredExercises) { exercise in
                                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                                        ExerciseCard(exercise: exercise)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            exerciseViewModel.exerciseName = ""
                            exerciseViewModel.exerciseDescription = ""
                            exerciseViewModel.exerciseTool = ""
                            exerciseViewModel.selectedExerciseType = "Strength"
                            exerciseViewModel.selectedMuscleGroups = []
                            isPresentingAddExerciseView = true
                        }) {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $isPresentingAddExerciseView) {
                            AddExerciseView(exerciseViewModel: exerciseViewModel)
                        }
                    }
                }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Exercises")
        }
    }
}
