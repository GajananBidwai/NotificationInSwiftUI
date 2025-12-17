//
//  CenterDelegate.swift
//  NotificationInSwiftUI
//
//  Created by Neosoft on 17/12/25.
//

import Foundation
import UserNotifications

class CenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner]
    }
    
    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let identifier = response.actionIdentifier
        if identifier == "deleteButton" {
            print("Delete Button Pressed")
        }
    }
}
