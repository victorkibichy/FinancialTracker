//
//  CustomColor.swift
//  FinancialTracker
//
//  Created by Kibichy on 24/09/2025.
//

import Foundation
import SwiftUI



extension Color {
    
    static let deepGreen = Color(hex: 0x006400)
    static let financialGreen = Color(hex: 0x66951F) 
    static let vibrantGreen = Color(hex: 0x80BA27)
    static let tealAccent = Color(hex: 0x2AB7CA)
    
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r: UInt64
        let g: UInt64
        let b: UInt64
        
        switch hex.count {
        case 3:
            r = (int >> 8) * 17
            g = ((int >> 4) & 0xF) * 17
            b = (int & 0xF) * 17
        case 6:
            r = (int >> 16) & 0xFF
            g = (int >> 8) & 0xFF
            b = int & 0xFF
        default:
            r = 0
            g = 0
            b = 0
        }
        
        self.init(
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0
        )
    }
}



