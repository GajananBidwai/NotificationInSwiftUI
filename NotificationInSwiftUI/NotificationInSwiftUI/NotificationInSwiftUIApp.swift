//
//  NotificationInSwiftUIApp.swift
//  NotificationInSwiftUI
//
//  Created by Neosoft on 16/12/25.
//

import SwiftUI

@main
struct NotificationInSwiftUIApp: App {
    let appData = ApplicationData.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appData)
        }
    }
}
