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
            ForEach(0..<7, id: \.self) { i in
                Button() {
                    settings.daysShowing[i].toggle()
                } label: {
                    HStack {
                        Image(systemName: settings.daysShowing[i] ? "checkmark.square.fill" : "square")
                        Text(daysOfWeek[i])
                    }.font(.headline)
                }
            }
        }
    }
}
