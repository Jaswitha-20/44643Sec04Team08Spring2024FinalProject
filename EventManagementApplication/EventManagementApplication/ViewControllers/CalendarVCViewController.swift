//
//  CalendarVCViewController.swift
//  EasyEvents
//
//  Created by Kumar Chandu on 4/11/24.
//

import UIKit
import FSCalendar
import EventKit
import AnimatedGradientView

struct YourEventType {
    var title: String
    var startDate: Date
    var endDate: Date
    // Add any other properties relevant to your events
}


class CalendarVCViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    @IBAction func createEventButtonTapped(_ sender: UIButton) {
        
        createEvent()
        
    }
    
    
    @IBOutlet weak var calendar: FSCalendar!
    
    
    private let eventStore = EKEventStore()
        private var eventsForDate: [Date: [YourEventType]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
        calendar.delegate = self
        calendar.dataSource = self
        requestCalendarAccess()
    }

    private func requestCalendarAccess() {
        eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    self?.fetchEventsForNextMonth()
                }
            } else {
                print("Access to calendar not granted or an error occurred.")
            }
        }
    }
    
    
    private func createEvent() {
        let event = EKEvent(eventStore: eventStore)
        event.title = "Test Event"
        event.startDate = Date()
        event.endDate = Date().addingTimeInterval(3600) // 1 hour
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.save(event, span: .thisEvent)
            print("Event created successfully.")
        } catch {
            print("Error creating event: \(error.localizedDescription)")
        }
    }


       private func fetchEventsForNextMonth() {
           let startDate = Date()
           let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
           let eventsPredicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
           let events = eventStore.events(matching: eventsPredicate)

           for event in events {
               let eventType = YourEventType(title: event.title, startDate: event.startDate, endDate: event.endDate)
               let date = Calendar.current.startOfDay(for: event.startDate)
               if var eventsArray = eventsForDate[date] {
                   eventsArray.append(eventType)
                   eventsForDate[date] = eventsArray
               } else {
                   eventsForDate[date] = [eventType]
               }
           }
           calendar.reloadData()
       }

       func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
           return eventsForDate[Calendar.current.startOfDay(for: date)]?.count ?? 0
       }

       func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
           if let events = eventsForDate[Calendar.current.startOfDay(for: date)] {
               print("Selected date has \(events.count) event(s)")
               // Handle event selection as needed
           }
       }
   }
    
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        // Implement logic to determine if there are events for the date
//        return 0 // Return the number of events for the date
//    }
//    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        // Implement logic for when a date is selected
//    }
//    
//    func fetchEventsForDate(date: Date) {
//        // Use EventKit to fetch events for the given date
//    }
//    func updateCalendarUIWithEvents(events: [YourEventType]) {
//        // Update the calendar UI to display the events
//    }
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        // Implement logic for when the calendar's current page changes
//    }






    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


