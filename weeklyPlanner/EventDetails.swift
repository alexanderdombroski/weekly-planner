//
//  EventDetails.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/9/24.
//

import SwiftUI

struct EventDetails: View {
    var event = Event(title: "Work", details: "Go to McDonalds", color: "blue")
    
    var body: some View {
        Text(event.title).font(.title)
        HStack {
            Text("\(event.day)")
            Text(event.timeToString())
        }
        Text(event.details).font(.subheadline)
    }
}


