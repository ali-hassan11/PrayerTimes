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
        
        NavigationView {
            Color.init(.secondarySystemBackground).overlay(
                VStack() {
                    Spacer()
                    DateView(hijriDate: $viewModel.hijriDate, gregorianDate: $viewModel.gregorianDate)
                    Spacer()
                    PrayerTimesListView(prayers: $viewModel.prayers)
                        .cornerRadius(25)
                    Spacer()
                }
                .animation(.spring())
                .padding(.horizontal, 20)
            )
            .navigationBarTitle("Hatfield, UK", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: locatePressed, label: {
                Image(systemName: "mappin.and.ellipse")
            }))
        }
    }
    
    func locatePressed() {
        print("locatePressed")
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
