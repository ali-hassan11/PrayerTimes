//
//  AppView.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import SwiftUI

struct TabsView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @State var colorScheme: Color
    
    var body: some View {
        TabView {
            PrayerTimesHomeView(viewModel: viewModel, colorScheme: $colorScheme)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Times")
                }
            SettingsView(date: $viewModel.date,
                         colorScheme: $colorScheme,
                         locationManager: viewModel.locationManager,
                         viewModel: viewModel)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .accentColor(colorScheme)
    }
}
