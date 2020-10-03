//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

@main
struct PrayerTimesApp: App {
    
    let settingsConfiguration: SettingsConfiguration
    let viewModel: PrayerTimeListViewModel
    
    init() {
        self.settingsConfiguration = SettingsConfiguration.shared
        self.viewModel = PrayerTimeListViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            TabsView(viewModel: viewModel).environmentObject(settingsConfiguration)
        }
    }
}
