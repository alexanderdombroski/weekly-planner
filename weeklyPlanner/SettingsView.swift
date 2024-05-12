//
//  SettingsView.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/7/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Bindable var settings: ChosenSettings
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var body: some View {
        VStack(alignment: .leading) {
            CheckBox(isChecked: settings.militaryTime, title: "Military Time") {
                settings.militaryTime.toggle()
            }
            ForEach(0..<7, id: \.self) { i in
                CheckBox(isChecked: settings.daysShowing[i], title: daysOfWeek[i]) {
                    settings.daysShowing[i].toggle()
                }
            }
        }
    }
}

// Creates a checkbox and automatically adjusts image from a Bool variable.
struct CheckBox: View {
    var isChecked: Bool
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                Text(title)
            }
            .font(.headline)
        }
    }
}
