//
//  LatitudeAdjustmentMethod.swift
//  PrayerTimes
//
//  Created by user on 15/10/2020.
//

import Foundation

enum LatitudeAdjustmentMethod: Int, CaseIterable {
    case middleOfTheNight
    case oneSeventh
    case angleBased
    
    var index: Int {
        return rawValue
    }
    
    var toString: String {
        switch self {
        case .middleOfTheNight: return "Middle of the Night"
        case .oneSeventh: return "One Seventh"
        case .angleBased: return "Angle Based"
        }
    }
}
