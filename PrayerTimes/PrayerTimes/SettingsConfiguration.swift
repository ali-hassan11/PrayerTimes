//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

class SettingsConfiguration: ObservableObject {
    
    @Published var dateType: DateType
    @Published var method: Method
    @Published var school: School
    
    init(dateType: DateType, method: Method, school: School) {
        self.dateType = dateType
        self.method = method
        self.school = school
    }
}
