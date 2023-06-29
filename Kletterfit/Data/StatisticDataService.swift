//
//  StatisticDataService.swift
//  Kletterfit
//
//  Created by Jana Eichholz on 08.06.23.
//

import Foundation
import SwiftUI

struct StatisticDataService {
    
    func getStatisticData() -> [StatisticItem] {
        
        return [StatisticItem(finishedTrainingDate: Date().updateHour(value: 8), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 9), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 10), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 11), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 12), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 13), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 14), finishedTrainingDuration: 5, finishedTrainingName: "Seilspringen"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 15), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 16), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 17), finishedTrainingDuration: 3, finishedTrainingName: "Situps"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 18), finishedTrainingDuration: 8, finishedTrainingName: "Seilspringen"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 19), finishedTrainingDuration: 2, finishedTrainingName: "Planks"),
                StatisticItem(finishedTrainingDate: Date().updateHour(value: 20), finishedTrainingDuration: 3, finishedTrainingName: "Situps")]
    }
}


