//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

class SettingsConfiguration: ObservableObject {
    
    @Published var dateMode: DateMode
    @Published var method: Method
    @Published var school: School
    @Published var locationInfo: LocationInfo

    //@Published var colorScheme: UIColor
    
    static let shared = SettingsConfiguration()
    
    private init() {
        //Get all from UserDefaults/Core data
        dateMode = .gregorian
        method = .muslimWorldLeague
        school = .shafi
        timeZone = .current
        locationInfo = LocationInfo(locationName: "Donnayyyy", lat: 53.5228, long: 1.1285) //
    }
    
    private init(dateType: DateMode, method: Method, school: School, locationInfo: LocationInfo) {
        self.dateMode = dateType
        self.method = method
        self.school = school
        self.locationInfo = locationInfo
    }
}
