//
//  SelectionItem.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct SelectionItem: View {
    @EnvironmentObject var themeManager: ThemeManager

    var imageName: String
    var isSelected = false
    var body: some View {
        ZStack {
            Circle().foregroundStyle(isSelected ? themeManager.currentTheme.primaryColor : Color.white).frame(width: 150, height: 150)
            
       
            Circle().foregroundStyle(Color.white).frame(width: 130, height: 130)
        
            Image(imageName).resizable().scaledToFit().frame(width:110, height: 110)
        }
    }
}

#Preview {
    SelectionItem(imageName: "hedgehog")
}
