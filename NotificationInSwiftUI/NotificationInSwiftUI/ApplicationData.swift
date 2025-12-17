//
//  ApplicationData.swift
//  NotificationInSwiftUI
//
//  Created by Neosoft on 16/12/25.
//

import Foundation
import Observation
import UserNotifications
import UIKit

@Observable class ApplicationData: @unchecked Sendable {
    @ObservationIgnored let center = UNUserNotificationCenter.current()
    @ObservationIgnored let centerDelegate: CenterDelegate = CenterDelegate()
    
    static let shared: ApplicationData = ApplicationData()
    
    private init () {
//        center.delegate = centerDelegate
    }
    
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
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "sample-3s.mp3"))
            let idImage = "attach\(UUID())"
            if let urlImage = await getThumbNail(id: idImage) {
                if let attachment = try? UNNotificationAttachment(identifier: idImage, url: urlImage, options: nil) {
                    content.attachments = [attachment]
                }
            }
            
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
    
    func getThumbNail(id: String) async ->  URL?{
        let manager = FileManager.default
        if let docUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileUrl = docUrl.appendingPathComponent("\(id).png") as URL?
            if let image = UIImage(named: "sample") {
                if let thumbnail = await image.preparingThumbnail(of: CGSize(width: 100, height: 100)) {
                    if let imageData = thumbnail.pngData() {
                        if let _ = try? imageData.write(to: fileUrl!) {
                            return fileUrl
                        }
                    }
                }
            }
        }
        return nil
    }
    
    
    
}
