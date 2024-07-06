//
//  TimerViewModel.swift
//  nomodoro
//
//  Created by G on 2024-02-04.
//

import Foundation
enum TimerState {
    case active
    case paused
    case resumed
    case reset
}
final class TimerViewModel: ObservableObject {
    let imageDataSource : [String: [String : [String]]] = ["hedgehog" : ["pizza" : ["hedgehog_pizza_1",
                                             "hedgehog_pizza_2",
                                             "hedgehog_pizza_3",
                                             "hedgehog_pizza_4",
                                             "hedgehog_pizza_5",
                                             "hedgehog_pizza_6"],
                                
                                "cookie" : ["hedgehog_cookie_1",
                                              "hedgehog_cookie_2",
                                              "hedgehog_cookie_3",
                                              "hedgehog_cookie_4",
                                              "hedgehog_cookie_5",
                                            "hedgehog_cookie_6"],
                                
                                "cake" :   ["hedgehog_cake_1",
                                              "hedgehog_cake_2",
                                              "hedgehog_cake_3",
                                              "hedgehog_cake_4",
                                              "hedgehog_cake_5",
                                            "hedgehog_cake_6",
                                            "hedgehog_cake_7"],
                                
                                "ramen" :   ["hedgehog_ramen_1",
                                               "hedgehog_ramen_2",
                                               "hedgehog_ramen_3",
                                               "hedgehog_ramen_4",
                                               "hedgehog_ramen_5",
                                               "hedgehog_ramen_6"]],
                  
                  "fox" :      ["pizza" : ["fox_pizza_1",
                                             "fox_pizza_2",
                                             "fox_pizza_3",
                                             "fox_pizza_4",
                                             "fox_pizza_5",
                                             "fox_pizza_6"],
                                
                                "cookie" : ["fox_cookie_1",
                                             "fox_cookie_2",
                                             "fox_cookie_3",
                                             "fox_cookie_4",
                                             "fox_cookie_5",
                                             "fox_cookie_6"],
                                
                                "cake" :   ["fox_cake_1",
                                             "fox_cake_2",
                                             "fox_cake_3",
                                             "fox_cake_4",
                                             "fox_cake_5",
                                             "fox_cake_6"],
                                
                                "ramen" :  ["fox_ramen_1",
                                             "fox_ramen_2",
                                             "fox_ramen_3",
                                             "fox_ramen_4",
                                             "fox_ramen_5",
                                              "fox_ramen_6"]],
                  
                  "penguin" :   ["pizza" : ["penguin_pizza_1",
                                             "penguin_pizza_2",
                                             "penguin_pizza_3",
                                             "penguin_pizza_4",
                                             "penguin_pizza_5",
                                             "penguin_pizza_6"],
                                
                                "cookie" : ["penguin_cookie_1",
                                             "penguin_cookie_2",
                                             "penguin_cookie_3",
                                             "penguin_cookie_4",
                                             "penguin_cookie_5",
                                             "penguin_cookie_6"],
                                
                                "cake" :   ["penguin_cake_1",
                                             "penguin_cake_2",
                                             "penguin_cake_3",
                                             "penguin_cake_4",
                                             "penguin_cake_5",
                                             "penguin_cake_6"],
                                
                                "ramen" :  ["penguin_ramen_1",
                                             "penguin_ramen_2",
                                             "penguin_ramen_3",
                                             "penguin_ramen_4",
                                             "penguin_ramen_5",
                                             "penguin_ramen_6"]],
                  "rabbit" :   ["pizza" : ["rabbit_pizza_1",
                                             "rabbit_pizza_2",
                                             "rabbit_pizza_3",
                                             "rabbit_pizza_4",
                                             "rabbit_pizza_5",
                                             "rabbit_pizza_6"],
                                
                                "cookie" : ["rabbit_cookie_1",
                                             "rabbit_cookie_2",
                                             "rabbit_cookie_3",
                                             "rabbit_cookie_4",
                                             "rabbit_cookie_5",
                                             "rabbit_cookie_6"],
                                
                                "cake" :   ["rabbit_cake_1",
                                             "rabbit_cake_2",
                                             "rabbit_cake_3",
                                             "rabbit_cake_4",
                                             "rabbit_cake_5",
                                             "rabbit_cake_6"],
                                
                                "ramen" :  ["rabbit_ramen_1",
                                             "rabbit_ramen_2",
                                             "rabbit_ramen_3",
                                             "rabbit_ramen_4",
                                             "rabbit_ramen_5",
                                             "rabbit_ramen_6"]]]
    
    let petImages = [PetType.hedgehog.rawValue, PetType.fox.rawValue, PetType.penguin.rawValue, PetType.rabbit.rawValue]
    let snackImages = [SnackType.pizza.rawValue,
                       SnackType.cake.rawValue,
                       SnackType.cookie.rawValue,
                               SnackType.ramen.rawValue]
    @Published var images: [String]
    @Published var selectionType = SelectionType.Pet {
        didSet {
            switch selectionType {
            case .Pet:
                images = petImages
            case .Snack:
                images = snackImages
            }
        }
    }
    
    var selectedPet: PetType = .hedgehog
    var selectedSnack: SnackType = .pizza
    
    @Published var activeImageIndex = 0
    @Published var timerState: TimerState = .reset
    @Published var timerDuration: Double = 0
    @Published var timerCounter: Double = 0 {
        didSet {
            if timerState != .reset {
                activeImageIndex = Int((timerDuration-timerCounter)/(timerDuration / Double(images.count)))
                if activeImageIndex < images.count {
                    self.currentImageUrl = self.images[self.activeImageIndex]
                }
            } else {
                DispatchQueue.main.async {
                    self.timerDuration = self.timerCounter
                }
            }
        }
    }
    @Published var currentImageUrl: String?
    @Published var isShowingAlert = (false, "")

    
    init() {
        images = petImages
        
        if images.isEmpty {
            isShowingAlert = (true, "There is a problem with images")
            print("There is a problem with retrieving GIF images")
        }
       
        if timerState != .reset {
            activeImageIndex = Int((timerDuration-timerCounter)/(timerDuration / Double(images.count)))
            if activeImageIndex < images.count {
                self.currentImageUrl = self.images[self.activeImageIndex]
            }
        } else {
            self.currentImageUrl = self.images[0]
        }
    }
    
    func setTimerState(_ state: TimerState) {
        if state == .active {
            guard let selectedPet = UserDefaults.standard.value(forKey: "selectedPet") as? String else { return }
            guard let selectedSnack = UserDefaults.standard.value(forKey: "selectedSnack") as? String else { return }
            guard let imagesForPet = imageDataSource[selectedPet] else { return }
            images = imagesForPet[selectedSnack] ?? []
            self.currentImageUrl = images[0]
        } else if state == .reset {
            if selectionType == .Pet {
                images = petImages
            } else {
                images = snackImages
            }
        } else if state == .paused {
            
        }
        
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
