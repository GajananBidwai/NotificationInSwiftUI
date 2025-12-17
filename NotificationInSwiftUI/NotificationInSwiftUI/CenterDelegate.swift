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
}
