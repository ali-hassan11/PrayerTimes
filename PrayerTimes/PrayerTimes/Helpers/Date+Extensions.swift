//
//  Date+Extensions.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import Foundation

extension Date {
    var timestampString: String {
        return String(Int(self.timeIntervalSince1970))
    }
    
    var timestampPlus24HoursString: String {
        return String(self.timeIntervalSince1970 + 86400)
    }
    
    var plus24Hours: Date {
        return self.addingTimeInterval(TimeInterval(86400))
    }
    
    var minus24Hours: Date {
        return self.addingTimeInterval(TimeInterval(-86400))
    }
}
