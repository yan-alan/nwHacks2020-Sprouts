//
//  CreateNotification.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-12.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import Foundation
import NotificationCenter
struct CreateNotification {
    static func notification(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Water Your Plants"
        if(plant.name == "No Name") {
            content.body = "Your \(plant.scientificName) needs to be watered"
        } else {
            content.body = "Your \(plant.name) needs to be watered"
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(exactly: plant.wateringInterval)!, repeats: false)
        let request = UNNotificationRequest(identifier: "request-\(plant.scientificName)", content: content, trigger: trigger)
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }

    }
}
