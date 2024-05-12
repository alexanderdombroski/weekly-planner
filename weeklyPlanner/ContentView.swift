//
//  ContentView.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/6/24.
//

import SwiftUI
import SwiftData

// Main Calendar View
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext // For removing, adding, etc.
    @Query(sort: \Event.dayNum) private var events: [Event] // Gets events from persistant SwiftData
    @Environment(ChosenSettings.self) private var chosenSettings
    
    // Toggle Bools that open sheet views
    @State private var showingSettings = false
    @State private var showingEventMenu = false
    
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(Array(zip(Day.allCases, chosenSettings.daysShowing)), id: \.0) { day, isShowing in
                    isShowing ? // Ternary Operator only shows a day if true
                    AnyView(DayList(
                        titleDay: day.rawValue,
                        events: filterEvents(day: day),
                        militaryTime: chosenSettings.militaryTime
                    )) : AnyView(EmptyView())
                }
                .onDelete(perform: deleteEvent)
            }
            .toolbar {
                // ----- Add Event Button -----
                ToolbarItem {
                    Button() {
                        showingEventMenu.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                // ----- Settings Button -----
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            // ----- Pages -----
            .sheet(isPresented: $showingSettings) {
                SettingsView(settings: chosenSettings)
            }
            .sheet(isPresented: $showingEventMenu) {
                EventView()
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    // Delete an event
    func deleteEvent(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(events[index])
            }
        }
    }
    
    // Filter by Day
    private func filterEvents(day: Day) -> [Event] {
        events.filter() { $0.day == day }
    }
}


// A single Day section in the NavigationSplitView List
struct DayList: View {
    let titleDay: String
    let events: [Event]
    let militaryTime: Bool
    
    var body: some View {
        Section(header: Text(titleDay)) {
            ForEach(events) { event in
                NavigationLink(destination: EventDetails(event: event)) {
                    Text(event.title).foregroundStyle(event.color.toColor())
                    Text(militaryTime ? event.timeToMilitary() : event.timeToString())
                }
            }
        }
    }
}
