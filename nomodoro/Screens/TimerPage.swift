//
//  TimerPage.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI

struct TimerPage: View {
    @Binding var path: NavigationPath
    @StateObject private var viewModel = TimerViewModel()
    var body: some View {
        ZStack {
            Color("backgroundColor", bundle: Bundle.main)
            VStack(spacing: 50) {
                ZStack {
                    CircularTimerView(timerState: $viewModel.timerState,value: $viewModel.timerCounter, minValue: 0, maxValue: 60 * 60).frame(width: 350, height: 350)
                    
                    if viewModel.timerState == .reset || viewModel.timerState == .paused {
                        //TODO: Reset / pause animation - can be custom for each or not will decide
                        let selectedPet = UserDefaults.standard.value(forKey: "selectedPet") as! String
                        Image(selectedPet).resizable().scaledToFit().frame(width: 220, height: 220)
                    } else {
                        GIFImage(name:viewModel.currentImageUrl ?? viewModel.images[0]).frame(width: 220, height: 220)
                    }
                }
                
                Text(viewModel.getTimeString()).font(Font.custom("Montserrat-SemiBold", size: 60)).foregroundStyle(Color.white)
                
                HStack {
                    if viewModel.timerState == .reset {
                        Button("start") {
                            viewModel.setTimerState(.active)
                        }.buttonStyle(PrimaryButton())
                    } else {
                        if viewModel.timerState == .paused {
                            Button("resume") {
                                viewModel.setTimerState(.resumed)
                            }.buttonStyle(PrimaryButton())
                        } else {
                            Button("pause") {
                                viewModel.setTimerState(.paused)
                            }.buttonStyle(PrimaryButton())
                        }
                        Button("reset") {
                            viewModel.setTimerState(.reset)
                        }.buttonStyle(PrimaryButton())
                    }
                }
            }
            
        }.ignoresSafeArea().navigationBarTitle("", displayMode: .inline).onAppear() {
            print(UserDefaults.standard.value(forKey: "selectedPet"))
            print(UserDefaults.standard.value(forKey: "selectedSnack"))
        }
    }
}

#Preview {
    TimerPage(path: .constant(NavigationPath()))
}
