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
    
    func toString() -> String {
        return String(rawValue)
    }
}
