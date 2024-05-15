//
//  SettingsPage.swift
//  nomodoro
//
//  Created by Gökçe Nacak on 2024-04-26.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct CustomThemePicker: View {
    @EnvironmentObject var themeManager: ThemeManager

    let themeList: [Theme]
    @Binding var selection: Theme
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 40) {
            ForEach(themeList, id: \.self) { theme in
                Button(action: {
                    self.selection = theme
                    themeManager.setTheme(theme)
                }) {
                    Circle()
                        .fill(theme.backgroundColor)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: self.selection == theme ? 3 : 0)
                        )
                }
            }
        }
    }
}

struct SettingsPage: View {
    let themeList = [Theme.sodapop,
                     Theme.coral,
                     Theme.bubblegum,
                     Theme.lilac,
                     Theme.sky,
                     Theme.aquadream,
                     Theme.herby,
                     Theme.lemonade
                    ]

    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedTheme: Theme = .sodapop

    @State var showColorPicker = false
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
        
            HStack(spacing:32) {
                Text("Select theme color:")
                Button(action: {
                    showColorPicker = true
                }) {
                    Circle()
                        .fill(
                            themeManager.currentTheme.backgroundColor
                            )
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                        )
                }
            }.padding().sheet(isPresented: $showColorPicker) {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            showColorPicker = false
                        }) {
                            Image(systemName: "xmark.circle.fill").font(.largeTitle) .symbolRenderingMode(.hierarchical)
                                .foregroundStyle(.gray)
                        }.padding([.trailing],18).padding([.bottom],40)
                            .padding([.top],18)
                    }
                    
                    CustomThemePicker(themeList: themeList, selection: $selectedTheme).presentationDetents([.fraction(0.33)])
                }
               
         }
        }.ignoresSafeArea().navigationTitle("Settings")
    }
}

#Preview {
    return SettingsPage()
}
