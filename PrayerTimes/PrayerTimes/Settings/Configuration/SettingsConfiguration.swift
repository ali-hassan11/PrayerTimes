//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation
import SwiftUI

//MOVE
let LOCATIONKEY = "locationkKey"
let COLORKEY = "colorKey"
let METHODKEY = "methodKey"
class SettingsConfiguration: ObservableObject {
    
    @Published var method: Method
    @Published var school: School
    @Published var latitudeAdjustmentMethod: LatitudeAdjustmentMethod
    @Published var locationInfo: LocationInfo //Make optional
    @Published var colorScheme: Color
        
    static let shared = SettingsConfiguration()
    
    private init() {
        //Get all from UserDefaults/Core data
        method = Self.getMethodSetting() ?? .muslimWorldLeague
        school = .shafi
        latitudeAdjustmentMethod = .angleBased
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
}

//MARK: Color Scheme
extension SettingsConfiguration {
    
    func saveColorSetting(_ newColor: Color) {
        self.colorScheme = newColor
        UserDefaults.standard.setValue(newColor.toString(), forKey: COLORKEY)
    }
    
    private static func getColorSetting() -> Color? {
        guard let colorName = UserDefaults.standard.string(forKey: COLORKEY) else { return nil }
        return Color(colorName: colorName)
    }
}

//MARK: Method
extension SettingsConfiguration {
    
    func saveMethodSetting(_ method: Method) {
        self.method = method
        UserDefaults.standard.setValue(method.rawValue, forKey: METHODKEY)
    }
    
    private static func getMethodSetting() -> Method? {
        guard let methodIndex = UserDefaults.standard.object(forKey: METHODKEY) as? Int else { return nil }
        return Method(rawValue: methodIndex)
    }
}
