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
    @State var colorScheme: Color = SettingsConfiguration.shared.colorScheme
        
    init() {
        self.viewModel = PrayerTimeListViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            TabsView(viewModel: viewModel, colorScheme: colorScheme)
        }
    }
}
