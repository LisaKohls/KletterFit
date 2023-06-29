//
//  AddExerciseView.swift
//  Kletterfit
//
//  Created by Lisa Salzer on 14.06.23.
//
import SwiftUI
import CoreData

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var exerciseViewModel: ExerciseViewModel

    let muscleGroups = ["Abs", "Arms", "Back", "Chest", "Glutes", "Legs"]
    let exerciseTypes = ["Strength", "Cardio"]

    @FetchRequest(sortDescriptors: []) var exercises: FetchedResults<Exercises>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New exercise")) {
                    TextField("Name", text: $exerciseViewModel.exerciseName)
                        .foregroundColor(exerciseViewModel.isShowingNameError ? .red : .primary)
                        .onChange(of: exerciseViewModel.exerciseName) { newValue in
                            exerciseViewModel.isShowingNameError = newValue.isEmpty
                        }
                    if exerciseViewModel.isShowingNameError {
                        Text("Please enter a name").foregroundColor(.red)
                    }
                    
                    Picker("Exercise Type", selection: $exerciseViewModel.selectedExerciseType) {
                        ForEach(exerciseTypes, id: \.self) { exerciseType in
                            Text(exerciseType)
                                .tag(exerciseType)
                        }
                    }


                    DisclosureGroup("Muscle Groups", isExpanded: $exerciseViewModel.isMuscleGroupsExpanded) {
                        List {
                            ForEach(muscleGroups, id: \.self) { muscleGroup in
                                MultipleSelectionRow(title: muscleGroup, isSelected: isSelected(muscleGroup))
                                    .onTapGesture {
                                        toggleSelection(muscleGroup)
                                    }
                            }
                        }
                    }
                    if exerciseViewModel.isShowingMuscleGroupsError && exerciseViewModel.selectedMuscleGroups.isEmpty {
                        Text("Please select at least one muscle group").foregroundColor(.red)
                    }

                    
                    TextField("Description", text: $exerciseViewModel.exerciseDescription)
                    TextField("Tools", text: $exerciseViewModel.exerciseTool)
                }
            }
            .navigationBarTitle("Add exercise")
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                trailing:
                    Button("Add") {
                        if exerciseViewModel.exerciseName.isEmpty {
                            exerciseViewModel.isShowingNameError = true
                        } else if exerciseViewModel.selectedExerciseType == "Strength" && exerciseViewModel.selectedMuscleGroups.isEmpty {
                            exerciseViewModel.isShowingMuscleGroupsError = true
                        } else {
                            exerciseViewModel.addExercise(moc: moc)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(exerciseViewModel.exerciseName.isEmpty || (exerciseViewModel.selectedExerciseType == "Strength" && exerciseViewModel.selectedMuscleGroups.isEmpty))

            )
        }
    }
    
    func isSelected(_ muscleGroup: String) -> Bool {
        return exerciseViewModel.selectedMuscleGroups.contains(muscleGroup)
    }
    
    func toggleSelection(_ muscleGroup: String) {
        if isSelected(muscleGroup) {
            exerciseViewModel.selectedMuscleGroups.remove(muscleGroup)
        } else {
            exerciseViewModel.selectedMuscleGroups.insert(muscleGroup)
        }
    }
}
