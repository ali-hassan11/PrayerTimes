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
class SettingsConfiguration: ObservableObject {
    
    @Published var method: Method
    @Published var school: School
    @Published var latitudeAdjustmentMethod: LatitudeAdjustmentMethod
    @Published var locationInfo: LocationInfo //Make optional
    @Published var colorScheme: Color
        
    static let shared = SettingsConfiguration()
    
    private init() {
        //Get all from UserDefaults/Core data
        method = .muslimWorldLeague
        school = .shafi
        latitudeAdjustmentMethod = .angleBased
        locationInfo = SettingsConfiguration.getLocationInfoSetting() ?? LocationInfo(locationName: "Manchester, England", lat: 53.4808, long: 2.2426)
        colorScheme = SettingsConfiguration.getColorSetting()
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
}

//MARK: Color Scheme
extension SettingsConfiguration {
    func updateColorSetting(_ newColor: Color) {
        self.colorScheme = newColor
        UserDefaults.standard.setValue(newColor.toString(), forKey: COLORKEY)
    }
    
    static func getColorSetting() -> Color {
        guard let colorName = UserDefaults.standard.string(forKey: COLORKEY) else { return .init(.systemPink) }
        return Color(colorName: colorName)
    }
}
