//
//  SettingsView.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isLocationSearchPresented = false
    @State private var isMethodSelectViewPresentated = false
    @State private var isSchoolSelectViewPresentated = false
    @State private var isHighLattitudeSelectViewPresentated = false
    @Binding var date: Date //(Here -> viewModel property in TabsView)
    
    var body: some View {
        
        NavigationView {
            let settings = SettingsConfiguration.shared
            
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
                    SubTitleCell(title: "Prayer Time Calculation",
                                 subTitle: settings.method.toString,
                                 imageName: "chevron.forward",
                                 action: {
                                    isMethodSelectViewPresentated.toggle()
                                 })
                        .sheet(isPresented: $isMethodSelectViewPresentated) {
                            SettingSelectView(type: .method, title: "Prayer Time Calculation")
                        }
                    
                    SubTitleCell(title: "Asr Calculation Method",
                                 subTitle: settings.school.toString,
                                 imageName: "chevron.forward",
                                 action: {
                                    isSchoolSelectViewPresentated.toggle()
                                 })
                        .sheet(isPresented: $isSchoolSelectViewPresentated) {
                            SettingSelectView(type: .school, title: "Asr Calculation Method")
                                .navigationBarTitle("Asr Calculation Method", displayMode: .inline)
                        }
                    
                    SubTitleCell(title: "High Latitude Adjustment",
                                 subTitle: "Angle-based method",
                                 imageName: "chevron.forward",
                                 action: {
                                    isHighLattitudeSelectViewPresentated.toggle()
                                 })
                        .sheet(isPresented: $isHighLattitudeSelectViewPresentated) {
                            SettingSelectView(type: .highLatitudeAdjustment, title: "High Latitude Adjustment")
                        }
                }
            }
            .navigationBarTitle("Settings")
        }
        .listStyle(InsetGroupedListStyle())
    }
}
