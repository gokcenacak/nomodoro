//
//  nomodoroApp.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

@main
struct nomodoroApp: App {
    @StateObject private var themeManager = ThemeManager(initialTheme: Theme.sodapop)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)

        }
    }
}
