//
//  School.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

enum School: Int {
    case shafi
    case hanafi
    
    var indexString: Int {
        return rawValue
    }
    
    func toString() -> String {
        switch self {
        case .shafi: return "Shafi"
        case .hanafi: return "Hanafi"
        }
    }
}
