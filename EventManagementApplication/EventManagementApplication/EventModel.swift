struct EventResponse: Codable {
    let categories: [String: Category]?
}

struct Category: Codable {
    let events: [Event]?
}

struct Event: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let images: [String]?
    let eventFee: String?
    let guests: Int?
    let createdByEmail: String?
    let createdByName: String?
    let date: String?
    let time: String?
    let location: String?
    let eventId: String?
    let data: [EventData]?
}

struct EventData: Codable {
    let organizerId: Int?
    
    let organizerName: String?
    let email: String?
    let contact: String?
    let address: String?
    let inField: String?
    let eventsDone: Int?
    let rating: Double?
    let description: String?
    let date: String?
    let location: String?
    let guestsAllowed: String?
    let price: Int?
    let image: [String]?
    let team_members: [String]?
}

 



struct Organizer: Codable {
    let name: String?
    let email: String?
    let contact: String?
    let address: String?
}

 
