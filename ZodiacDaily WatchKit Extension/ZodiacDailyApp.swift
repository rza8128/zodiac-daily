//
//  ZodiacDailyApp.swift
//  ZodiacDaily WatchKit Extension
//
//  Created by Abraham Rubio on 12/02/21.
//

import SwiftUI

@main
struct ZodiacDailyApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
