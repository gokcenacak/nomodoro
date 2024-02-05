//
//  MainView.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
            NavigationStack(path: $path) {
                ZStack {
                    Color("backgroundColor", bundle: Bundle.main)
                        .ignoresSafeArea()
                    PetSelectionPage(path: $path)
                        .navigationDestination(for: String.self) { view in
                            switch view {
                            case "SnackSelectionPage":
                                SnackSelectionPage(path: $path)
                            case "TimerPage":
                                TimerPage(path:$path)
                            default:
                                Text("Unknown")
                            }
                    }
                }.ignoresSafeArea()
            }.accentColor(.white)
            
            //.ignoresSafeArea()
        
    }
}

#Preview {
    MainView()
}
