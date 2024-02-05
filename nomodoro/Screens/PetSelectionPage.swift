//
//  PetSelectionPage.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct PetSelectionPage: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack(spacing:40) {
            Text("select a pet").font(Font.custom("Montserrat-Semibold", size: 32)).foregroundStyle(Color.white)
            SelectionGroup(images: ["hedgehog", "hedgehog", "hedgehog", "hedgehog"]) { selection in
                UserDefaults.standard.setValue(selection, forKey: "petIndex")
            }
            
            Button("next") {
                path.append("SnackSelectionPage")
            }.buttonStyle(PrimaryButton())
        }
.padding().navigationBarTitle("", displayMode: .inline)
    }
}

#Preview {
    ZStack {
        Color("backgroundColor")
        PetSelectionPage(path: .constant(NavigationPath()))
    }.ignoresSafeArea()
}
