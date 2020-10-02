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
        self.settingsConfiguration = SettingsConfiguration(dateType: .gregorian,
                                                           method: .muslimWorldLeague,
                                                           school: .shafi)//Get from UD/CD
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
