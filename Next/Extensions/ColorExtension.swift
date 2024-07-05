//
//  ColorExtension.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//

import Foundation
import SwiftUI

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}

extension Color {
    static let theme = ColorTheme()
    
    init(hex: Int, opacity: Double = 1) {
            self.init(
                .sRGB,
                red: Double((hex >> 16) & 0xff) / 255,
                green: Double((hex >> 08) & 0xff) / 255,
                blue: Double((hex >> 00) & 0xff) / 255,
                opacity: opacity
            )
        }
}
