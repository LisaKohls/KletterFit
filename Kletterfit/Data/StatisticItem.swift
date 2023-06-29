//
//  StatisticItem.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 08.06.23.
//

import Foundation
import SwiftUI

struct StatisticItem:Identifiable{
    var id = UUID()
    var finishedTrainingDate: Date
    var finishedTrainingDuration: Int
    var finishedTrainingName: String
    var animate: Bool = false
}

extension Date {
    func updateHour(value:Int ) -> Date{
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

var analytics: [StatisticItem] = [
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 8), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 9), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 10), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 11), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 12), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 13), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 14), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 15), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 16), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 17), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 18), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 19), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
    StatisticItem(finishedTrainingDate: Date().updateHour(value: 20), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
]

