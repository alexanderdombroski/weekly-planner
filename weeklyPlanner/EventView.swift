//
//  EventView.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/8/24.
//

import SwiftUI

struct EventView: View {
    @Environment(\.dismiss) var dismiss // Close the view
    @Environment(\.modelContext) private var modelContext // Load in SwiftData Model Functions
    
    // Declare Variables
    let colorList: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
    @State var event = Event(title: "", details: "", startTime: Time(hour: 8, minute: 0), endTime: Time(hour: 9, minute: 0), color: "red")
    
    @State private var startMinute = "0"
    @State private var startHour = "0"
    @State private var endMinute = "0"
    @State private var endHour = "0"
    @State private var isPM = true
    @State private var isPMEnd = true
    
    var body: some View {
        Text("Create an Event").font(.title)
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
        // ----- Text Entries -----
        HStack {
            VStack {
                Text("Title")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("", text: $event.title)
                    .padding(3)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .topLeading)
                    .border(.black)
                Text("Description")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextEditor(text: $event.details)
                    .padding(3)
                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .topLeading)
                    .border(.black)
            }
            
            // ----- Color Buttons -----
            VStack {
                ForEach(colorList, id: \.self) { color in
                    Button() {
                        event.color = color.description
                    } label: {
                        Color(color)
                            .frame(minWidth: 20, maxWidth: 25, minHeight: 20, maxHeight: 25)
                            .clipShape(.circle)
                            .shadow(color: event.color.toColor() == color ? .black.opacity(0.95) : Color.clear, radius: 3)
                    }
                }
            }
        }
        .padding(10)
        
        // ----- DateTime Selectors -----
        HStack {
            Picker("Select a day", selection: $event.day) {
                ForEach(Day.allCases, id: \.self) { day in
                    Text(day.rawValue).tag(day)
                }
            }
                .pickerStyle(.wheel)
                .frame(maxWidth: 100, maxHeight: 125)
            VStack {
                TimeEntry(timeLabel: "Start", hour: $startHour, minute: $startMinute, isPM: $isPM)
                TimeEntry(timeLabel: "End", hour: $endHour, minute: $endMinute, isPM: $isPMEnd)
            }
        }
        
        // ----- Save Button -----
        Button {
            saveData()
        } label: {
            Text("Save")
        }
        .padding()
        .clipShape(.capsule)
        .border(.black)
        .frame(maxWidth: .infinity)
        Spacer()
    }
    
    // Saves an instance of the Event Model
    func saveData() {
        // Parse Numbers
        var start = Int(startHour) ?? 1 // Defaults to 1 AM if fails
        var end = Int(endHour) ?? 1
        if isPM { start += 12 }
        if isPMEnd { end += 12 }
        
        // Create Event
        event = Event(
            title: event.title,
            details: event.details,
            day: event.day,
            startTime: Time(hour: start, minute: Int(startMinute) ?? 0),
            endTime: Time(hour: end, minute: Int(endMinute) ?? 0),
            color: event.color
        )
        modelContext.insert(event) // Save operation
        dismiss() // Close the page
    }
}



// Graphic containing a text box that enforces number input
struct NumberField: View {
    let hint: String
    let minEntry: Int
    let maxEntry: Int
    @Binding var value: String
    var body: some View {
        TextField(hint, text: $value)
            .padding(3)
            .keyboardType(.numberPad)
            .border(.black)
            .multilineTextAlignment(.center)
            .frame(maxWidth: 30)
            .onTapGesture {
                value = ""  // Clear the text when tapped
            }
            .onChange(of: value) { oldValue, newValue in
            // Ensure the entered value is within the specified range
            if let number = Int(newValue) {
                self.value = min(max(number, minEntry), maxEntry).description
            } else {
                self.value = ""
            }
        }
    }
}



// Graphic with UI elements to input time
struct TimeEntry: View {
    let timeLabel: String
    @Binding var hour: String
    @Binding var minute: String
    @Binding var isPM: Bool
    
    var body: some View {
        Text(timeLabel).font(.caption2)
        HStack {
            NumberField(hint: "00", minEntry: 1, maxEntry: 12, value: $hour)
            Text(":")
            NumberField(hint: "00", minEntry: 0, maxEntry: 59, value: $minute)
            Text(isPM ? "PM" : "AM")
            Toggle(isOn: $isPM, label: {
                EmptyView()
            }).frame(maxWidth: 50)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
        }
    }
}
