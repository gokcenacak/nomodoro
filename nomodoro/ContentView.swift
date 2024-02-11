//
//  ContentView.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash: Bool = true

    var body: some View {
        ZStack {
            Color("backgroundColor", bundle: Bundle.main)
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
