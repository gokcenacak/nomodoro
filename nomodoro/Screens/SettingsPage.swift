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
                                .stroke(themeManager.currentTheme.primaryButtonColor, lineWidth: self.selection == theme ? 3 : 0)
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
    @State private var enableNotifications: Bool = false
    
    @Binding var selectedDuration: Int?

    init(selectedDuration: Binding<Int?>) {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        self._selectedDuration = selectedDuration
    }
    
    var body: some View {
            List {
                NavigationLink {
                    TimerMinuteSelectionPage(selectedDuration: $selectedDuration)
                } label: {
                    HStack {
                        Text("Timer Duration")
                        Spacer()
                        Text("\(selectedDuration ?? 60) minutes").foregroundStyle(.gray)
                    }
                }
                
                Button{
                    openAppSettings()
                } label: {
                    HStack {
                        Text("Push Notifications").foregroundStyle(.black)
                        Spacer()
                        Text("\(enableNotifications ? "On" : "Off")").foregroundStyle(.gray)
                        Image(systemName: "chevron.right").font(.system(size: UIFont.systemFontSize, weight: .semibold)).opacity(0.25).foregroundStyle(.black)
                    }
                }
                
                Text("Contact us:")
                Text("Bug report:")
                HStack {
                    Text("Select theme color:")
                    Spacer()
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
                }.sheet(isPresented: $showColorPicker) {
                    VStack(spacing: 36) {
                        HStack {
                            Spacer()
                            Button(action: {
                                showColorPicker = false
                            }) {
                                Image(systemName: "xmark").font(.title2) .symbolRenderingMode(.hierarchical)
                                    .foregroundStyle(.gray)
                            }
                        }
                        
                        CustomThemePicker(themeList: themeList, selection: $selectedTheme).presentationDetents([.fraction(0.33)])
                    }.padding()
                   
             }
            }.scrollContentBackground(.hidden).background(themeManager.currentTheme.backgroundColor).navigationTitle("Settings").scrollDisabled(true).onAppear {
                getNotificationPermissionResult()
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                getNotificationPermissionResult()
            }
    }
    
    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    func getNotificationPermissionResult() {
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus  {
            case .authorized:
                enableNotifications = true
            case .denied, .notDetermined:
                enableNotifications = false
            default:
                enableNotifications = false
            }
        })
    }
}

#Preview {
    return SettingsPage(selectedDuration: Binding.constant(60))
}
