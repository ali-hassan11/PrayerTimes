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
    
    var plusOneDay: Date {
        return self.addingTimeInterval(TimeInterval(86400))
    }
    
    var minusOneDay: Date {
        return self.addingTimeInterval(TimeInterval(-86400))
    }
    
//    func convertToTimeZone(to desiredTimeZone: TimeZone, from currentimeZone: TimeZone) -> Date {
//        let delta = TimeInterval(currentimeZone.secondsFromGMT(for: self) - desiredTimeZone.secondsFromGMT(for: self))
//        print(delta)
//        print(desiredTimeZone)
//        print(currentimeZone)
//        return addingTimeInterval(delta)
//    }
}
