//
//  SettingsConfiguration.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

class SettingsConfiguration: ObservableObject {
    
    @Published var dateType: DateType
    
    init(dateType: DateType) {
        self.dateType = dateType
    }
}

//Nother class
enum DateType {
    case hijri
    case gregorian
}
