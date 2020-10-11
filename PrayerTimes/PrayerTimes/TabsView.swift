//
//  AppView.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import SwiftUI

struct TabsView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @State var address: String
    
    var body: some View {
        TabView {
            PrayerTimesHomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Times")
                }
            SettingsView(date: $viewModel.date)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
