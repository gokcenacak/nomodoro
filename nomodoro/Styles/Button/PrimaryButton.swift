//
//  PrimaryButton.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import Foundation
import SwiftUI

struct PrimaryButton: ButtonStyle {
    @EnvironmentObject var themeManager: ThemeManager
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 140, height: 70)
            .background(themeManager.currentTheme.primaryButtonColor)
            .font(Font.custom("Montserrat-SemiBold", size: 24))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
