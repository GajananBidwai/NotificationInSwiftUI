//
//  ApplicationData.swift
//  NotificationInSwiftUI
//
//  Created by Neosoft on 16/12/25.
//

import Foundation
import Observation
import UserNotifications

@Observable class ApplicationData: @unchecked Sendable {
    @ObservationIgnored let center = UNUserNotificationCenter.current()
    
    static let shared: ApplicationData = ApplicationData()
    private init () { }
    
    func askAuthorization() async -> Bool {
        do {
            let authorized = try await center.requestAuthorization(options: [.alert, .sound])
            return authorized
        } catch {
            print("Error \(error)")
            return false
        }
    }
    
    func postNotification(messeage: String) async {
        let authorization = await center.notificationSettings()
        if authorization.authorizationStatus == .authorized {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = messeage
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            let id = "reminder-\(UUID())"
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            
            do {
                try await center.add(request)
            } catch {
                print("Error \(error)")
            }
            
        }
    }
    
    
}
