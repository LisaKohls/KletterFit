//
//  ExerciseStore.swift
//  Kletterfit
//
//  Created by Lisa Salzer on 17.06.23.
//

import SwiftUI

class ExerciseStore: ObservableObject {
    @Published var exercises: [Exercises]
    
    init() {
        self.exercises = []
    }
    
    func addExercise(_ exercise: Exercises) {
        exercises.append(exercise)
    }
}


