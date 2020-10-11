//
//  SettingsView.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isLocationSearchPresented = false
    @Binding var date: Date //(Here -> viewModel property in TabsView)
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    ChooseColorCell(title: "Color Scheme", action: {})
                }
                
                Section {
                    SubTitleCell(title: "Location",
                                 subTitle: SettingsConfiguration.shared.locationInfo.locationName,
                                 imageName: "chevron.forward",
                                 action: {
                                    isLocationSearchPresented.toggle()
                                 })
                        .sheet(isPresented: $isLocationSearchPresented) {
                            LocationPicker(date: $date)
                        }
                }
                
                Section {
                    SubTitleCell(title: "Prayer Time Convention",
                                 subTitle: "Muslim World League",
                                 imageName: "chevron.forward",
                                 action: {})
                    SubTitleCell(title: "Asr Calculation Method",
                                 subTitle: "Hanafi",
                                 imageName: "chevron.forward",
                                 action: {})
                    SubTitleCell(title: "High Latitude Adjustment",
                                 subTitle: "Angle-based method",
                                 imageName: "chevron.forward",
                                 action: {})
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}
