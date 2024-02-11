//
//  SelectionGroup.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI
struct ImageSelectionItem: Identifiable {
    let id: Int
    let url: String
}
struct SelectionGroup: View {
    
    @Binding var images: [String]
    let columns = [GridItem(.flexible(), spacing: 0),
                   GridItem(.flexible(), spacing: 0)]
    @State var selectedItem: Int = 0
    var onSelectionChanged: (String)->()
    
    var body: some View {
        HStack {
            Button {
                if selectedItem == 0 {
                    selectedItem = images.count - 1
                } else {
                    selectedItem -= 1
                }
                onSelectionChanged(images[selectedItem])
            } label: {
                Image(systemName: "chevron.left").resizable().scaledToFit().frame(width: 40, height: 40).padding().foregroundStyle(Color.white).font(Font.title.weight(.black))
            }
            Image(images[selectedItem]).resizable().scaledToFit().frame(width: 150)
                .id(selectedItem)
                .transition(.scale.animation(.bouncy))
                
            Button {
                if selectedItem == images.count - 1 {
                    selectedItem = 0
                } else {
                    selectedItem += 1
                }
                onSelectionChanged(images[selectedItem])
            } label: {
                Image(systemName: "chevron.right").resizable().scaledToFit().frame(width: 40, height: 40).padding().foregroundStyle(Color.white).font(Font.title.weight(.black))
            }

        }
    }
    
   
}

#Preview {
    ZStack {
        Color.black
//        SelectionGroup(images: [SnackType.pizza.rawValue,
//                        SnackType.cake.rawValue,
//                        SnackType.cookie.rawValue,
//                                SnackType.ramen.rawValue], onSelectionChanged: {_ in })
    }
    
}
