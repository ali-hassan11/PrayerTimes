//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation
let LOCATIONKEY = "locationkKey"
class SettingsConfiguration: ObservableObject {
    
    @Published var dateMode: DateMode
    @Published var method: Method
    @Published var school: School
    @Published var locationInfo: LocationInfo
    
    func updateLocationSetting(_ locationInfo: LocationInfo) {
        self.locationInfo = locationInfo
        do {
            let data = try JSONEncoder().encode(locationInfo)
            UserDefaults.standard.setValue(data, forKey: LOCATIONKEY)
        } catch {
            print("Failed to save locationInfo to UserDefaults")
        }
    }
    
    static func getLocationInfoSetting() -> LocationInfo? {
        guard let data = UserDefaults.standard.data(forKey: LOCATIONKEY) else { return nil }
        
        do {
            let locationInfo = try JSONDecoder().decode(LocationInfo.self, from: data)
            return locationInfo
        } catch {
            print("Failed to decode location info")
            return nil
        }
    }
    
    //@Published var colorScheme: UIColor
    
    static let shared = SettingsConfiguration()
    
    private init() {
        //Get all from UserDefaults/Core data
        dateMode = .gregorian
        method = .muslimWorldLeague
        school = .shafi
        locationInfo = SettingsConfiguration.getLocationInfoSetting() ?? LocationInfo(locationName: "Donnayyyy", lat: 53.5228, long: 1.1285) //
    }
    
    private init(dateType: DateMode, method: Method, school: School, locationInfo: LocationInfo) {
        self.dateMode = dateType
        self.method = method
        self.school = school
        self.locationInfo = locationInfo
    }
}
