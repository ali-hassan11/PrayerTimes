//
//  AppView.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import SwiftUI

struct TabsView: View {
    
    let viewModel: PrayerTimeListViewModel
    
    var body: some View {
        TabView {
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            PrayerTimesHomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Times")
                }
            
        }
    }
}
