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
    
    @Published var dateMode: DateMode
    @Published var method: Method
    @Published var school: School
    @Published var locationInfo: LocationInfo //Make optional
    
    @Published var colorScheme: Color
    
    //@Published var colorScheme: UIColor
    
    static let shared = SettingsConfiguration()
    
    private init() {
        //Get all from UserDefaults/Core data
        dateMode = .gregorian
        method = .muslimWorldLeague
        school = .shafi
        locationInfo = SettingsConfiguration.getLocationInfoSetting() ?? LocationInfo(locationName: "Manchester, England", lat: 53.4808, long: 2.2426)
        colorScheme = SettingsConfiguration.getColorSetting()
    }
    
    private init(dateType: DateMode, method: Method, school: School, locationInfo: LocationInfo, colorScheme: Color) {
        self.dateMode = dateType
        self.method = method
        self.school = school
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

extension Color {
    
    init(colorName: ColorName.RawValue) {
        switch colorName {
        case ColorName.systemPink.rawValue:
            self.init(.systemPink)
        case ColorName.systemRed.rawValue:
            self.init(.systemRed)
        case ColorName.systemOrange.rawValue:
            self.init(.systemOrange)
        case ColorName.systemGreen.rawValue:
            self.init(.systemGreen)
        case ColorName.systemBlue.rawValue:
            self.init(.systemBlue)
        case ColorName.systemIndigo.rawValue:
            self.init(.systemIndigo)
        case ColorName.systemPurple.rawValue:
            self.init(.systemPurple)
        default:
            self.init(.systemPink)
        }
    }
    
    func toString() -> String {
        switch self {
        case .init(.systemPink):
            return ColorName.systemPink.rawValue
        case .init(.systemRed):
            return ColorName.systemRed.rawValue
        case .init(.systemOrange):
            return ColorName.systemOrange.rawValue
        case .init(.systemGreen):
            return ColorName.systemGreen.rawValue
        case .init(.systemBlue):
            return ColorName.systemBlue.rawValue
        case .init(.systemIndigo):
            return ColorName.systemIndigo.rawValue
        case .init(.systemPurple):
            return ColorName.systemPurple.rawValue
        default:
            return ColorName.systemPink.rawValue
        }
    }
}

enum ColorName: String {
    case systemPink
    case systemRed
    case systemOrange
    case systemGreen
    case systemBlue
    case systemIndigo
    case systemPurple
}
