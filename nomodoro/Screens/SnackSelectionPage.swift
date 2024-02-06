//
//  SnackSelectionPage.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct SnackSelectionPage: View {
    @Binding var path: NavigationPath
    @State var images = [SnackType.pizza.rawValue,
                         SnackType.cake.rawValue,
                         SnackType.cookie.rawValue,
                         SnackType.ramen.rawValue]
    
    var body: some View {
        ZStack {
            Color("backgroundColor", bundle: Bundle.main)
            VStack(spacing:40) {
                Text("select a snack").font(Font.custom("Montserrat-Semibold", size: 32)).foregroundStyle(Color.white)
                SelectionGroup(images: images, onSelectionChanged: { selection in
                    UserDefaults.standard.setValue(selection, forKey: "selectedSnack")
                })
                Button("next") {
                    path.append("TimerPage")
                }.buttonStyle(PrimaryButton())
            }.padding()
        }.ignoresSafeArea().navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    SnackSelectionPage(path: .constant(NavigationPath()))
}
