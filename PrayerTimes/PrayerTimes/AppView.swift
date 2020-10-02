//
//  AppView.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import SwiftUI

struct AppView: View {
    
    let viewModel: PrayerTimesHomeViewModel
    
    var body: some View {
        TabView {
            PrayerTimesHomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "clock.fill")
                    Text("Times")
                }
            PrayerTimesHomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }.accentColor(Color.init(.systemPink))

    }
}

//struct AppView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppView()
//    }
//}
