//
//  ContentView.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/6/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext // For removing, adding, etc.
    @Query private var events: [Event]
    @Environment(ChosenSettings.self) private var chosenSettings
    
    @State private var showingSettings = false
    @State private var showingEventMenu = false
    
    private var groupedEvents: [(Day, [Event])] {
        // Group events by their day attribute
        var eventsArray = Dictionary(grouping: events, by: { $0.day }).map { key, value in (key, value)}
        
        // Sort by start time
        for index in eventsArray.indices {
            eventsArray[index].1.sort { $0.startTime.hour < $1.startTime.hour }
        }
        
        // Group by day
        eventsArray.sort { $0.0.rawValue < $1.0.rawValue }
        return eventsArray
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(groupedEvents, id: \.0) { day, dayEvents in
                    Section(header: Text(day.rawValue)) {
                        ForEach(dayEvents) { event in
                            NavigationLink(destination: EventDetails(event: event)) {
                                Text(event.title).foregroundStyle(event.color.toColor())
                                Text(event.timeToString())
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            .toolbar {
                ToolbarItem {
                    Button() {
                        showingEventMenu.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button() {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
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
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(events[index])
            }
        }
    }
}

