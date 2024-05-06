//
//  Item.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/6/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
