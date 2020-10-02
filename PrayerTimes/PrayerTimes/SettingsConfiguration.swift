//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

class SettingsConfiguration: ObservableObject {
    
    @Published var dateType: DateMode
    @Published var method: Method
    @Published var school: School
    @Published var timeZone: TimeZone
    
    init(dateType: DateMode, method: Method, school: School, timeZone: TimeZone) {
        self.dateType = dateType
        self.method = method
        self.school = school
        self.timeZone = timeZone
    }
}
