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
                            NavigationView {
                                SettingSelectView(type: .method)
                            }
                            .navigationTitle("Prayer Time Calculation")
                        }
                    
                    SubTitleCell(title: "Asr Calculation Method",
                                 subTitle: settings.school.toString,
                                 imageName: "chevron.forward",
                                 action: {
                                    isSchoolSelectViewPresentated.toggle()
                                 })
                        .sheet(isPresented: $isSchoolSelectViewPresentated) {
                            NavigationView {
                                SettingSelectView(type: .school)
                            }
                            .navigationTitle("Prayer Time Calculation")
                        }
                    SubTitleCell(title: "High Latitude Adjustment",
                                 subTitle: "Angle-based method",
                                 imageName: "chevron.forward",
                                 action: {
                                    isHighLattitudeSelectViewPresentated.toggle()
                                 })
                        .sheet(isPresented: $isHighLattitudeSelectViewPresentated) {
                            NavigationView {
                                SettingSelectView(type: .highLatitudeAdjustment)
                            }
                            .navigationTitle("High Latitude Adjustment")
                        }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Settings")
        }
    }
}
