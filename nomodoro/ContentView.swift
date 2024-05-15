//
//  ContentView.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash: Bool = true
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
            if self.showSplash {
                SplashView()
            } else {
                TimerPage()
            }
        }.ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    self.showSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
