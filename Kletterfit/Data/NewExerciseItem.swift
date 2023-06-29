//
//  NewExerciseItem.swift
//  Kletterfit
//
//  Created by Lisa Salzer on 14.06.23.
//

import Foundation
import SwiftUI

struct NewExerciseItem: Identifiable {
    var id: UUID = UUID()
    var exerciseDescription: String
    var exerciseMuscleGroup: String
    var exerciseName: String
    var exerciseTools: String
    var exerciseType: String
}
