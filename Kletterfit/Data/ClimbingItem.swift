//
//  ClimbingItem.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 23.05.23.
//

import Foundation
import SwiftUI

struct ClimbingItem: Identifiable {
    
    var id: UUID = UUID()
    var name: String
    var description: String
    var imageOfRoute: Image
    var tries: Int8
    var color: String
    var background: Color
    var finished: Bool
    
}
