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
        self.settingsConfiguration = SettingsConfiguration(dateType: .hijri,
                                                           method: .muslimWorldLeague,
                                                           school: .shafi,
                                                           timeZone: .current)//Get from UserDefaults/CoreData
        self.viewModel = PrayerTimesHomeViewModel(settings: settingsConfiguration)
    }
    
    let settingsConfiguration: SettingsConfiguration
    let viewModel: PrayerTimesHomeViewModel
    
    var body: some Scene {
        WindowGroup {
            PrayerTimesHomeView(viewModel: PrayerTimesHomeViewModel(settings: settingsConfiguration)).environmentObject(settingsConfiguration)
        }
    }
}
