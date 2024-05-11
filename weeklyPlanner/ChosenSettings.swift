//
//  ChosenSettings.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/7/24.
//

import Foundation
import SwiftData

@Model
final class ChosenSettings {
    var daysShowing: [Bool]
    
    init(daysShowing: [Bool] = Array(repeating: true, count: 7)) {
        self.daysShowing = daysShowing
    }
}
