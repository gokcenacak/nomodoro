//
//  SplashView.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack(spacing: 0) {
                Image("splash_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                
                Text("nomodoro").font(Font.custom("Montserrat-SemiBold", size: 60)).foregroundStyle(Color.white)
        }
    }
}

#Preview {
    ZStack {
        Color(.red)
        SplashView()
    }
}
