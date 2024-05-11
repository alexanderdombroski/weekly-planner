//
//  Event.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/8/24.
//

import Foundation
import SwiftData
import SwiftUI

enum Day: String, CaseIterable, Codable {
    case Sunday = "Sun"
    case Monday = "Mon"
    case Tuesday = "Tue"
    case Wednesday = "Wed"
    case Thursday = "Thu"
    case Friday = "Fri"
    case Saturday = "Sat"
}

struct Time : Hashable, Codable {
    var hour: Int
    var minute: Int

    init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    func toString() -> String {
        "\(hour):\(minute == 0 ? "00" : String(minute))"
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
    
    init(title: String, details: String, day: Day = Day.Monday, startTime: Time = Time(hour: 8, minute: 0), endTime: Time = Time(hour: 9, minute: 0), color: String) {
        self.title = title
        self.details = details
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.color = color
    }
    
    func timeToString() -> String {
        "\(startTime.toString()) - \(endTime.toString())"
    }
}

