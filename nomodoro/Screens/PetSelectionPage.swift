//
//  PetSelectionPage.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct PetSelectionPage: View {
    @State var images = [PetType.hedgehog.rawValue,
                         PetType.fox.rawValue,
                         PetType.penguin.rawValue,
                         PetType.rabbit.rawValue]
    
    @Binding var path: NavigationPath
    var body: some View {
        VStack(spacing:40) {
            Text("select a pet").font(Font.custom("Montserrat-Semibold", size: 32)).foregroundStyle(Color.white)
            SelectionGroup(images: images) { selection in
                UserDefaults.standard.setValue(selection, forKey: "selectedPet")
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
