//
//  TimerViewModel.swift
//  nomodoro
//
//  Created by G on 2024-02-04.
//

import Foundation

final class TimerViewModel: ObservableObject {
    let images = ["hedgehog_pizza_dough", "hedgehog_pizza_dough_roll", "hedgehog_pizza_sauce", "hedgehog_pizza_ingredients", "hedgehog_pizza_cooking", "hedgehog_pizza_eating"]
    @Published var activeImageIndex = 0
    @Published var timerState: TimerState = .reset
    @Published var timerDuration: Double = 0
    @Published var timerCounter: Double = 0 {
        didSet {
            if timerState != .reset {
                activeImageIndex = Int((timerDuration-timerCounter)/(timerDuration / Double(images.count)))
                if activeImageIndex < images.count {
                    currentImageUrl = images[activeImageIndex]
                }
            } else {
                timerDuration = timerCounter
            }
        }
    }
    @Published var currentImageUrl: String = ""
    @Published var isShowingAlert = (false, "")
    
    enum TimerState {
        case active
        case paused
        case resumed
        case reset
    }
    
    init() {
        if timerState != .reset {
            activeImageIndex = Int((timerDuration-timerCounter)/(timerDuration / Double(images.count)))
            if activeImageIndex < images.count {
                currentImageUrl = images[activeImageIndex]
            }
        }
    }
    
    func setTimerState(_ state: TimerState) {
        timerState = state
    }
    
    func getTimeString() -> String {
        let duration: Duration
        if timerState == .reset {
            duration = Duration.seconds(timerDuration)
        } else {
            duration = Duration.seconds(timerCounter)
        }
        let format = duration.formatted(
            .time(pattern: .minuteSecond(padMinuteToLength: 2)))
        return format
    }
}
