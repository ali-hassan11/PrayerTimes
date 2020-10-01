//
//  PrayerTimesApp.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

@main
struct PrayerTimesApp: App {
    var body: some Scene {
        WindowGroup {
            PrayerTimesHomeView(viewModel: PrayerTimesHomeViewModel())
        }
    }
}
