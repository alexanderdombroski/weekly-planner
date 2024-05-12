//
//  weeklyPlannerApp.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/6/24.
//

import SwiftUI
import SwiftData

@main
struct weeklyPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [ChosenSettings.self, Event.self]) // Format the SwiftData container
    }
}

// Loading Screen
struct RootView: View {
    @Environment(\.modelContext) private var context
    @Query private var settings: [ChosenSettings]
    
    var body: some View {
        ContentView().onAppear() {
            if settings.isEmpty {
                context.insert(ChosenSettings()) // Init settings if there is none and insert
            }
        }.environment(settings.first ?? ChosenSettings()) // Set up environment
    }
}
