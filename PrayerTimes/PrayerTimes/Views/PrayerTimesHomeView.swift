//
//  ContentView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesHomeView: View {
    
    @ObservedObject var viewModel: PrayerTimesHomeViewModel
    @EnvironmentObject var settingsConfiguration: SettingsConfiguration
        
    var body: some View {
                
        VStack() {
            DateView(formattedDate: $viewModel.formattedDate)
            Spacer()
            NextPrayerView()
            PrayerTimesList(prayers: $viewModel.prayers)
            Spacer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesHomeView(viewModel: PrayerTimesHomeViewModel(configuration: SettingsConfiguration(dateType: .gregorian)))
    }
}
