//
//  TimerPage.swift
//  nomodoro
//
//  Created by G on 2024-02-02.
//

import SwiftUI
import UserNotifications

enum SelectionType: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case Pet = "pawprint.fill"
    case Snack = "fork.knife"
}

struct TimerPage: View {
    @EnvironmentObject var themeManager: ThemeManager

    @StateObject var viewModel = TimerViewModel()
    
    @AppStorage("selectedDuration")
    private var selectedDuration: Int?
    
    var body: some View {
        NavigationView {
            
            ZStack {
                themeManager.currentTheme.backgroundColor
                VStack(spacing: 40) {
                    Picker("", selection: $viewModel.selectionType) {
                        ForEach(SelectionType.allCases) { type in
                            Image(systemName:type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding().frame(width: 150).tint(Color.white).scaleEffect(CGSize(width: 1.5, height: 1.5))
                    
                    
                    ZStack {
                        CircularTimerView(timerState: $viewModel.timerState,value: $viewModel.timerCounter, minValue: 0, maxValue: Double((selectedDuration ?? 60) * 60)).frame(width: 350, height: 350)
                        
                        if viewModel.timerState == .reset || viewModel.timerState == .paused {
                            //TODO: Reset / pause animation - can be custom for each or not will decide
                            SelectionGroup(images: $viewModel.images) { selection in
                                if viewModel.selectionType == .Pet {
                                    UserDefaults.standard.setValue(selection, forKey: "selectedPet")
                                } else {
                                    UserDefaults.standard.setValue(selection, forKey: "selectedSnack")
                                }
                            }
                        } else {
                            GIFImage(name:viewModel.currentImageUrl ?? viewModel.images[0]).frame(width: 220, height: 220)
                        }
                    }
                    
                    Text(viewModel.getTimeString()).font(Font.custom("Montserrat-SemiBold", size: 72)).foregroundStyle(Color.white)
                    
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
                
            }.ignoresSafeArea().navigationTitle("")
            .toolbar {
                NavigationLink(destination: SettingsPage(selectedDuration: $selectedDuration)){
                    Image(systemName: "gearshape.fill").foregroundStyle(Color.white).dynamicTypeSize(.xxxLarge)
                }
            }
        }.tint(.white).onAppear {
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .normal)
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(themeManager.currentTheme.primaryButtonColor)
            if UserDefaults.standard.value(forKey: "selectedPet") == nil {
                // Value doesn't exist, set the default value
                UserDefaults.standard.set("hedgehog", forKey: "selectedPet")
            }
            if UserDefaults.standard.value(forKey: "selectedSnack") == nil {
                // Value doesn't exist, set the default value
                UserDefaults.standard.set("cookie", forKey: "selectedSnack")
            }
        }.onReceive(themeManager.objectWillChange) {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(themeManager.currentTheme.primaryButtonColor)
        }
        
    }
}

#Preview {

    return TimerPage()
}
