//
//  DataManager.swift
//  EventManagementApplication
//
//  Created by RAKESH SOMANABOINA on 3/21/24.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    typealias EventDetailCompletion = (Result<EventDetailResponse, Error>) -> Void

    func fetchDataFromAPI(completion: @escaping (EventResponse?, Error?) -> Void) {
        let urlString = "https://jsondata-ewow.onrender.com/json.json"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let eventResponse = try decoder.decode(EventResponse.self, from: data)
                completion(eventResponse, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func fetchOrganiserDataFromAPI(completion: @escaping ([Organizer]?, Error?) -> Void) {
        let urlString = "https://jsondata-ewow.onrender.com/json.json"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let eventResponse = try decoder.decode(EventResponse.self, from: data)
                
                // Create an array to hold the organizers
                var organizers: [Organizer] = []
                
                // Iterate through the categories and events to extract organizers
                if let categories = eventResponse.categories {
                    for (_, category) in categories {
                        if let events = category.events {
                            for event in events {
                                // Check if the event has an organizer and add it to the array
                                if let organizer = event.organizer {
                                    organizers.append(organizer)
                                }
                            }
                        }
                    }
                }
                
                // Return the array of organizers
                completion(organizers, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    
    // Define the function to fetch event details
    func fetchEventDetails(eventID: String, completion: @escaping EventDetailCompletion) {
        let urlString = "https://jsondata-ewow.onrender.com/json.json"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Add event ID as a parameter
        let parameters: [String: Any] = ["id": eventID]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                completion(.failure(NSError(domain: "HTTPError", code: statusCode, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let eventDetailResponse = try decoder.decode(EventDetailResponse.self, from: data)
                completion(.success(eventDetailResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }


}

