//
//  Color+Extension.swift
//  PrayerTimes
//
//  Created by user on 15/10/2020.
//

import SwiftUI

extension Color {
    
    enum ColorName: String {
        case systemPink
        case systemRed
        case systemOrange
        case systemGreen
        case systemBlue
        case systemIndigo
        case systemPurple
    }
    
    init(colorName: ColorName.RawValue) {
        switch colorName {
        case ColorName.systemPink.rawValue:
            self.init(.systemPink)
        case ColorName.systemRed.rawValue:
            self.init(.systemRed)
        case ColorName.systemOrange.rawValue:
            self.init(.systemOrange)
        case ColorName.systemGreen.rawValue:
            self.init(.systemGreen)
        case ColorName.systemBlue.rawValue:
            self.init(.systemBlue)
        case ColorName.systemIndigo.rawValue:
            self.init(.systemIndigo)
        case ColorName.systemPurple.rawValue:
            self.init(.systemPurple)
        default:
            self.init(.systemPink)
        }
    }
    
    func toString() -> String {
        switch self {
        case .init(.systemPink):
            return ColorName.systemPink.rawValue
        case .init(.systemRed):
            return ColorName.systemRed.rawValue
        case .init(.systemOrange):
            return ColorName.systemOrange.rawValue
        case .init(.systemGreen):
            return ColorName.systemGreen.rawValue
        case .init(.systemBlue):
            return ColorName.systemBlue.rawValue
        case .init(.systemIndigo):
            return ColorName.systemIndigo.rawValue
        case .init(.systemPurple):
            return ColorName.systemPurple.rawValue
        default:
            return ColorName.systemPink.rawValue
        }
    }
}
