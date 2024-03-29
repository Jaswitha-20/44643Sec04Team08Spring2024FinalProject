//
//  Event.swift
//  EasyEvents
//
//  Created by RAKESH SOMANABOINA on 3/29/24.
//

import Foundation

struct Event {
    let eventId: String
    let eventType: String
    let eventDate: Date
    let numberOfGuests: Int
    let organizer: String
    let location: String
    let budget: Double
    
    init(eventId: String, eventType: String, eventDate: Date, numberOfGuests: Int, organizer: String, location: String, budget: Double) {
        self.eventId = eventId
        self.eventType = eventType
        self.eventDate = eventDate
        self.numberOfGuests = numberOfGuests
        self.organizer = organizer
        self.location = location
        self.budget = budget
    }
}
