//
//  AppDelegate.swift
//  EasyEvents
//
//  Created by Kalikiri,Jaswitha on 2/21/24.
//

import UIKit
import Firebase
import EventKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
        let eventStore = EKEventStore()
        var permissionRequested = false

//        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//            return true
//        }

    func requestCalendarAccessIfNeeded(completion: @escaping (Bool) -> Void) {
            if !permissionRequested {
                eventStore.requestAccess(to: .event) { (granted, error) in
                    self.permissionRequested = true
                    completion(granted)
                }
            } else {
                completion(true)
            }
        }

        func fetchEventsForNextMonth(completion: @escaping ([EKEvent]?) -> Void) {
            let startDate = Date()
            let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)!
            let eventsPredicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: nil)
            let events = eventStore.events(matching: eventsPredicate)
            completion(events)
        }


    
    
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

