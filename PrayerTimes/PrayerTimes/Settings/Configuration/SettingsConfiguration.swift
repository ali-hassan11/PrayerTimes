//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation
import SwiftUI
import WidgetKit

//MOVE
let LOCATIONKEY = "locationkKey"
let COLORKEY = "colorKey"
let METHODKEY = "methodKey"
let SCHOOLKEY = "schoolKey"
let LATITUDEKEY = "latitudeKey"

class SettingsConfiguration: ObservableObject {
    
    private static let userDefaults = UserDefaults(suiteName: Constants.groupName)!
    private let userDefaults = UserDefaults(suiteName: Constants.groupName)!
    
    /*@Published*/ var method: Method
    /*@Published*/ var school: School
    /*@Published*/ var latitudeAdjustmentMethod: LatitudeAdjustmentMethod
                    var locationInfo: LocationInfo //Make optional
    @Published var colorScheme: Color
        
    static let shared = SettingsConfiguration()
    
    private init() {
        method = Self.getMethodSetting() ?? .muslimWorldLeague
        school = Self.getSchoolSetting() ?? .hanafi
        latitudeAdjustmentMethod = Self.getLatitudeSetting() ?? .angleBased
        locationInfo = Self.getLocationInfoSetting() ?? LocationInfo(locationName: "Manchester, England", lat: 53.4808, long: 2.2426)
        colorScheme = Self.getColorSetting() ?? .init(.systemPink)
    }
    
    private init(method: Method, school: School, latitudeAdjustmentMethod: LatitudeAdjustmentMethod, locationInfo: LocationInfo, colorScheme: Color) {
        self.method = method
        self.school = school
        self.latitudeAdjustmentMethod = latitudeAdjustmentMethod
        self.locationInfo = locationInfo
        self.colorScheme = colorScheme
    }
}

//MARK: Location Info
extension SettingsConfiguration {
    func saveLocationSetting(_ locationInfo: LocationInfo) {
        self.locationInfo = locationInfo
        do {
            let data = try JSONEncoder().encode(locationInfo)
            let userDefaults = UserDefaults(suiteName: Constants.groupName)!
            userDefaults.setValue(data, forKey: LOCATIONKEY)
        } catch {
            print("Failed to save locationInfo to UserDefaults")
        }
    }
    
    static func getLocationInfoSetting() -> LocationInfo? {
        guard let data = userDefaults.data(forKey: LOCATIONKEY) else { return nil }
        
        do {
            let locationInfo = try JSONDecoder().decode(LocationInfo.self, from: data)
            return locationInfo
        } catch {
            print("Failed to decode location info")
            return nil
        }
    }
}

//MARK: Color Scheme
extension SettingsConfiguration {
    
    //Made private as color scheme selection disabled for now
    private func saveColorSetting(_ newColor: Color) {
        self.colorScheme = newColor
        WidgetCenter.shared.reloadTimelines(ofKind: "Prayer_Times_Widget")
        userDefaults.setValue(newColor.toString(), forKey: COLORKEY)
    }
    
    static func getColorSetting() -> Color? {

//        guard let colorName = userDefaults.string(forKey: COLORKEY) else { return nil }
//        return Color(colorName: colorName)
        return Color("BlueBlue")
    }
}

//MARK: Method
extension SettingsConfiguration {
    
    func saveMethodSetting(_ method: Method) {
        self.method = method

        userDefaults.setValue(method.rawValue, forKey: METHODKEY)
    }
    
    private static func getMethodSetting() -> Method? {
        let userDefaults = UserDefaults(suiteName: Constants.groupName)!

        guard let index = userDefaults.object(forKey: METHODKEY) as? Int else { return nil }
        return Method(rawValue: index)
    }
}

//MARK: School
extension SettingsConfiguration {
    
    func saveSchoolSetting(_ school: School) {
        self.school = school
        
        let userDefaults = UserDefaults(suiteName: Constants.groupName)!

        userDefaults.setValue(school.rawValue, forKey: SCHOOLKEY)
    }
    
    private static func getSchoolSetting() -> School? {
        guard let index = userDefaults.object(forKey: SCHOOLKEY) as? Int else { return nil }
        return School(rawValue: index)
    }
}

//MARK: High Latitude Method
extension SettingsConfiguration {
    
    func saveLatitudeSetting(_ latitudeAdjustmentMethod: LatitudeAdjustmentMethod) {
        self.latitudeAdjustmentMethod = latitudeAdjustmentMethod

        userDefaults.setValue(latitudeAdjustmentMethod.rawValue, forKey: SCHOOLKEY)
    }
    
    private static func getLatitudeSetting() -> LatitudeAdjustmentMethod? {

        guard let index = userDefaults.object(forKey: LATITUDEKEY) as? Int else { return nil }
        return LatitudeAdjustmentMethod(rawValue: index)
    }
}


