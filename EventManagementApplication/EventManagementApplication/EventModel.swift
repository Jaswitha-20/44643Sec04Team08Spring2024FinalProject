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
    let organizer: Organizer?
}

struct Organizer: Codable {
    let name: String?
    let email: String?
    let contact: String?
    let address: String?
    let inField: String?
    let eventsDone: Int?
    let rating: Double?
}


struct EventDetailResponse: Codable {
    let msg: String?
    let data: [EventDetailData]?
}

struct EventDetailData: Codable {
    let event_title: String?
    let description: String?
    let date: String?
    let time: String?
    let location: String?
    let guests_allowed: Int?
    let price: Int?
    let team_members: [String]?
    let organizer: Organizer?
}


//struct EventDetailDataHistory: Codable {
//    let event_title: String?
//    let description: String?
//    let date: String?
//    let location: String?
//    let guests_allowed: Int?
//    let price: Int?
//    let organizer: Organizer?
//}
