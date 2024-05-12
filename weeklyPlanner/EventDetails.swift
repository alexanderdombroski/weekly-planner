//
//  EventDetails.swift
//  weeklyPlanner
//
//  Created by Alex Dombroski on 5/9/24.
//

import SwiftUI

// View that displays expanded details of the event
struct EventDetails: View {
    var event: Event
    
    var body: some View {
        Text(event.title).font(.title)
        HStack {
            Text("\(event.day)")
            Text(event.timeToString())
        }
        Text(event.details).font(.subheadline)
    }
}


