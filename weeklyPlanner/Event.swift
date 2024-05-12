//
//  Event.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/8/24.
//

import Foundation
import SwiftData
import SwiftUI

// Enum for every day
enum Day: String, CaseIterable, Codable, Identifiable {
    var id: String { rawValue } // Makes rawValues ID so enum conforms to Identifiable protocol
    case Sunday = "Sun"
    case Monday = "Mon"
    case Tuesday = "Tue"
    case Wednesday = "Wed"
    case Thursday = "Thu"
    case Friday = "Fri"
    case Saturday = "Sat"
}

// Requires Hashable and Codeable to correctly work with SwiftData
struct Time : Hashable, Codable {
    var hour: Int // Military time representation of time
    var minute: Int
    var isPm: Bool {
        hour >= 12
    }
    
    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    private func formatMinute() -> String {
        minute == 0 ? "00" : String(minute)
    }
    func toString() -> String {
        // ie 4:45 PM
        "\(hour >= 13 ? hour - 12 : hour):\(formatMinute()) \(isPm ? "PM" : "AM")"
    }
    func toMilitary() -> String {
        // ie 16:45
        "\(hour):\(formatMinute())"
    }
}

@Model
final class Event {
    var title: String
    var details: String
    var day: Day
    var startTime: Time
    var endTime: Time
    var color: String
    
    init(title: String, details: String, day: Day = Day.Monday, startTime: Time = Time(hour: 8, minute: 0), endTime: Time = Time(hour: 9, minute: 0), color: String, dayNum: Int = 0) {
        self.title = title
        self.details = details
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.color = color
        self.dayNum = Event.weekDayNumbers[day.rawValue] ?? 1
    }
    
    // Returns time in a readable string format
    func timeToString() -> String {
        "\(startTime.toString()) - \(endTime.toString())"
    }
    func timeToMilitary() -> String {
        "\(startTime.toMilitary()) - \(endTime.toMilitary())"
    }
    
    // For sorting and grouping by date
    var dayNum: Int
    static let weekDayNumbers = [
        "Sun": 0,
        "Mon": 1,
        "Tue": 2,
        "Wed": 3,
        "Thu": 4,
        "Fri": 5,
        "Sat": 6
    ]
}

