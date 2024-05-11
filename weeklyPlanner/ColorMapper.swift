//
//  extensions.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/8/24.
//

import Foundation
import SwiftUI

extension String {
    func toColor() -> Color {
        // Define color descriptions and their corresponding colors
        let colorMappings: [String: Color] = [
            "red": .red,
            "orange": .orange,
            "yellow": .yellow,
            "green": .green,
            "cyan": .cyan,
            "blue": .blue,
            "purple": .purple
        ]
        
        if let color = colorMappings[self.lowercased()] {
            return color
        } else {
            // Return black if the description does not match any color
            return .black
        }
    }
}

