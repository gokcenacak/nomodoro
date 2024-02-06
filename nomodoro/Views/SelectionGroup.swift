//
//  SelectionGroup.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct SelectionGroup: View {
    let images: [String]
    let columns = [GridItem(.flexible(), spacing: 0),
                   GridItem(.flexible(), spacing: 0)]
    @State var selectedItem: Int = 0
    var onSelectionChanged: (String)->()
    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            
            ForEach(images.indices, id:\.self) { count in
                SelectionItem(imageName: images[count], isSelected: count == selectedItem).onTapGesture {
                    selectedItem = count
                    onSelectionChanged(images[selectedItem])
                }
            }
        }.onAppear() {
            selectedItem = 0
            onSelectionChanged(images[selectedItem])
        }
    }
}

#Preview {
    SelectionGroup(images:["hedgehog", "hedgehog","hedgehog", "hedgehog"]) { selection in
        
    }
}
