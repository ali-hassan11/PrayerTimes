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
            Spacer()
            DateView(formattedDate: $viewModel.formattedDate)
            NextPrayerView(prayer: $viewModel.nextPrayer)
            PrayerTimesListView(prayers: $viewModel.prayers)
            Spacer()
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.68, blendDuration: 0.5))
        .padding(.horizontal, 20)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let settings = SettingsConfiguration(dateType: .hijri,
                                           method: .muslimWorldLeague,
                                           school: .hanafi,
                                           timeZone: .current)
        let viewModel = PrayerTimesHomeViewModel(settings: settings)
        PrayerTimesHomeView(viewModel: viewModel)
    }
}
