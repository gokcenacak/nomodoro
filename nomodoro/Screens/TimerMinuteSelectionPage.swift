//
//  TimerMinuteSelectionPage.swift
//  nomodoro
//
//  Created by Gökçe Nacak on 2024-07-06.
//

import Foundation
import SwiftUI

struct TimerMinuteSelectionPage: View {
    let durations = [20,25,30,35,40,45,50,55,60]
    
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var selectedDuration: Int?
    @State private var localSelectedDuration: Int?

    var body: some View {
        List(durations, id: \.self) { duration in
            HStack {
                Text("\(duration) minutes")
                Spacer()
                if localSelectedDuration == duration {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                // Update the selected item id in AppStorage
                localSelectedDuration = duration
            }
        }.scrollContentBackground(.hidden).background(themeManager.currentTheme.backgroundColor).navigationTitle("Timer Duration Selection").scrollDisabled(true)
            .onDisappear {
                selectedDuration = localSelectedDuration
            }.onAppear {
                localSelectedDuration = selectedDuration
            }
    }
}

#Preview {
    return TimerMinuteSelectionPage(selectedDuration: Binding.constant(60))
}
