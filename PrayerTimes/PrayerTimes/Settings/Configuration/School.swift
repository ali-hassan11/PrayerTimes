//
//  School.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

enum School: Int, CaseIterable {
    case shafi
    case hanafi
    
    var index: Int {
        return rawValue
    }
    
    var toString: String {
        switch self {
        case .shafi: return "Shafi"
        case .hanafi: return "Hanafi"
        }
    }
}
