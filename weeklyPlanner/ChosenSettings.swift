//
//  ChosenSettings.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/7/24.
//

import Foundation
import SwiftData

// SwiftData Model for picking settings
@Model
final class ChosenSettings {
    var daysShowing: [Bool]
    var militaryTime: Bool
    
    init(daysShowing: [Bool] = Array(repeating: true, count: 7), militaryTime: Bool = false) {
        self.daysShowing = daysShowing
        self.militaryTime = militaryTime
    }
}
