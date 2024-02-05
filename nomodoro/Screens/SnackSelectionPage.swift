//
//  SnackSelectionPage.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct SnackSelectionPage: View {
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            Color("backgroundColor", bundle: Bundle.main)
            VStack(spacing:40) {
                Text("select a snack").font(Font.custom("Montserrat-Semibold", size: 32)).foregroundStyle(Color.white)
                SelectionGroup(images: ["slice_pizza", "slice_pizza", "slice_pizza", "slice_pizza"], onSelectionChanged: { selection in
                    UserDefaults.standard.setValue(selection, forKey: "snackIndex")
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
