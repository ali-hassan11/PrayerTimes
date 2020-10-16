//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI
import BackgroundTasks

@main
struct PrayerTimesApp: App {
    
    let viewModel: PrayerTimeListViewModel
    @ObservedObject var settings: SettingsConfiguration
        
    init() {
        self.viewModel = PrayerTimeListViewModel()
        self.settings = SettingsConfiguration.shared
    }
    
    var body: some Scene {
        WindowGroup {
            TabsView(viewModel: viewModel, colorScheme: settings.colorScheme)
        }
    }
}
