//
//  ContentView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesHomeView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @EnvironmentObject var settingsConfiguration: SettingsConfiguration
    
    var body: some View {
        
        NavigationView {
            Color.init(.secondarySystemBackground).overlay(
                VStack() {
                    Spacer()
                    //DateView(hijriDate: $viewModel.hijriDate, gregorianDate: $viewModel.gregorianDate)
                    Spacer()
                    MultiplePrayerListView()
                        .cornerRadius(25)
                    Spacer()
                }
                .animation(.spring())
                .padding(.horizontal, 20)
            )
            .navigationBarTitle("Hatfield, UK", displayMode: .inline)
            .navigationBarItems(leading: Button(action: locatePressed, label: {
                Image(systemName: "mappin.and.ellipse")
            }), trailing: Button(action: mapPressed, label: {
                Image(systemName: "calendar")
            }))
        }
    }
    
    func locatePressed() {
        print("locatePressed")
    }
    
    func mapPressed() {
        print("mapPressed")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let settings = SettingsConfiguration(dateType: .hijri,
                                           method: .muslimWorldLeague,
                                           school: .hanafi,
                                           timeZone: .current)
        let viewModel = PrayerTimeListViewModel(settings: settings)
        PrayerTimesHomeView(viewModel: viewModel)
    }
}
