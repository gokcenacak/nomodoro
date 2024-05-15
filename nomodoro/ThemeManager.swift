//
//  ThemeManager.swift
//  nomodoro
//
//  Created by Gökçe Nacak on 2024-05-15.
//

import Foundation
import SwiftUI

struct Theme: Hashable, Equatable {
    var backgroundColor: Color
    var primaryColor: Color
    var secondaryColor: Color
    var primaryButtonColor: Color
    
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.backgroundColor == rhs.backgroundColor && lhs.primaryColor == rhs.primaryColor && lhs.secondaryColor == rhs.secondaryColor && lhs.primaryButtonColor == rhs.primaryButtonColor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(backgroundColor)
        hasher.combine(primaryColor)
        hasher.combine(secondaryColor)
        hasher.combine(primaryButtonColor)
    }
}

//    let colorList = [Color(hex: "#FFC297"),
//                     Color(hex: "#FF9C9D"),
//                     Color(hex: "#FFBAEE"),
//                     Color(hex: "#D8D3FF"),
//                     Color(hex: "#9EE4FF"),
//                     Color(hex: "#8AFFD6"),
//                     Color(hex: "#ABFF90"),
//                     Color(hex: "#F8FF99")]
extension Theme {
    //Orange theme
    static let `sodapop` = Self(
        backgroundColor: Color(hex: "#FFC297"),
        primaryColor: Color(hex: "#E95D3C"),
        secondaryColor: Color(hex: "#F8A179"),
        primaryButtonColor: Color(hex: "#EE7652")
    )
    
    //Red theme
    static let `coral` = Self(
        backgroundColor: Color(hex: "#FF9C9D"),
        primaryColor: Color(hex: "#FF4C4F"),
        secondaryColor: Color(hex: "#FF7D7E"),
        primaryButtonColor: Color(hex: "#FF6365")
    )
    
    static let `bubblegum` = Self(
        backgroundColor: Color(hex: "#FFBAEE"),
        primaryColor: Color(hex: "#FF6CD9"),
        secondaryColor: Color(hex: "#FF8FE3"),
        primaryButtonColor: Color(hex: "#FF51D3")
    )
    
    static let `lilac` = Self(
        backgroundColor: Color(hex: "#D8D3FF"),
        primaryColor: Color(hex: "#8D7DFF"),
        secondaryColor: Color(hex: "#B5AAFF"),
        primaryButtonColor: Color(hex: "#725FFF")
    )
    
    static let `sky` = Self(
        backgroundColor: Color(hex: "#9EE4FF"),
        primaryColor: Color(hex: "#2EC4FF"),
        secondaryColor: Color(hex: "#6AD5FF"),
        primaryButtonColor: Color(hex: "#00B7FF")
    )
    static let `aquadream` = Self(
        backgroundColor: Color(hex: "#98DDC5"),
        primaryColor: Color(hex: "#30C893"),
        secondaryColor: Color(hex: "#69D3AE"),
        primaryButtonColor: Color(hex: "#00AB6F")
    )
    
    static let `herby` = Self(
        backgroundColor: Color(hex: "#93DC7B"),
        primaryColor: Color(hex: "#4EBA2A"),
        secondaryColor: Color(hex: "#77CE5A"),
        primaryButtonColor: Color(hex: "#2AA900")
    )
    
    static let `lemonade` = Self(
        backgroundColor: Color(hex: "#FFD47D"),
        primaryColor: Color(hex: "#FFB84C"),
        secondaryColor: Color(hex: "#FFC868"),
        primaryButtonColor: Color(hex: "#FFB54F")
    )
    
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme
    
    init(initialTheme: Theme) {
        self.currentTheme = initialTheme
    }
    
    func setTheme(_ theme: Theme) {
        self.currentTheme = theme
    }
}
