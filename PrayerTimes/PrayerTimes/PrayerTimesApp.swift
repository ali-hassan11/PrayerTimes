//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

@main
struct PrayerTimesApp: App {
    
    init() {
        self.settingsConfiguration = SettingsConfiguration(dateType: .gregorian)//Get from UD/CD
    }
    
    let settingsConfiguration: SettingsConfiguration
    
    var body: some Scene {
        WindowGroup {
            PrayerTimesHomeView(viewModel: PrayerTimesHomeViewModel(configuration: settingsConfiguration)).environmentObject(settingsConfiguration)
        }
    }
}
