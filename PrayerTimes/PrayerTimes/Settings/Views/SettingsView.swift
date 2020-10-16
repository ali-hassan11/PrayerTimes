//
//  SettingsView.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import SwiftUI
import CoreLocation

struct SettingsView: View {
    
    //Dependencies
    @Binding var date: Date
    @Binding var colorScheme: Color
    let locationManager: CLLocationManager
    
    @State private var isLocationSearchPresented = false
    @State private var isLocationLocateMePresented = false
    
    @State private var isMethodSelectViewPresentated = false
    @State private var isSchoolSelectViewPresentated = false
    @State private var isHighLattitudeSelectViewPresentated = false
        
    var body: some View {
        
        NavigationView {
            let settings = SettingsConfiguration.shared
            
            List {
                //MARK: Color
                Section {
                    ChooseColorCell(colorScheme: $colorScheme, title: "Theme", action: {})
                }
                
                //MARK: Locate Me
                Section(header: Text(SettingsConfiguration.shared.locationInfo.locationName)) {
                    SettingCell(colorScheme: $colorScheme,
                                title: "Locate Me",
                                imageName: "location.fill",
                                action: {
                                //locationManager.startUpdatingLocation()
                                })
                        .sheet(isPresented: $isLocationLocateMePresented) {
                            Text("Locate me!")
                        }
                    
                    //MARK: Locate Search
                    SettingCell(colorScheme: $colorScheme,
                                title: "Search",
                                imageName: "magnifyingglass",
                                action: {
                                    isLocationSearchPresented.toggle()
                                })
                        .sheet(isPresented: $isLocationSearchPresented) {
                            LocationPicker(date: $date)
                        }
                }
                
                //MARK: Method
                Section {
                    SettingCell(colorScheme: $colorScheme,
                                title: "Prayer Time Calculation",
                                subTitle: settings.method.toString,
                                imageName: "chevron.forward",
                                action: {
                                    isMethodSelectViewPresentated.toggle()
                                })
                        .sheet(isPresented: $isMethodSelectViewPresentated) {
                            SettingSelectView(isPresented: $isMethodSelectViewPresentated, date: $date, type: .method, title: "Prayer Time Calculation")
                        }
                    
                    //MARK: School
                    SettingCell(colorScheme: $colorScheme,
                                title: "Asr Calculation Method",
                                subTitle: settings.school.toString,
                                imageName: "chevron.forward",
                                action: {
                                    isSchoolSelectViewPresentated.toggle()
                                })
                        .sheet(isPresented: $isSchoolSelectViewPresentated) {
                            SettingSelectView(isPresented: $isSchoolSelectViewPresentated, date: $date, type: .school, title: "Asr Calculation Method")
                                .navigationBarTitle("Asr Calculation Method", displayMode: .inline)
                        }
                    
                    //MARK: Latitude
                    SettingCell(colorScheme: $colorScheme,
                                title: "High Latitude Adjustment",
                                subTitle: settings.latitudeAdjustmentMethod.toString,
                                imageName: "chevron.forward",
                                action: {
                                    isHighLattitudeSelectViewPresentated.toggle()
                                })
                        .sheet(isPresented: $isHighLattitudeSelectViewPresentated) {
                            SettingSelectView(isPresented: $isHighLattitudeSelectViewPresentated, date: $date, type: .latitudeAdjustmentMethod, title: "High Latitude Adjustment")
                        }
                }
            }
            .navigationBarTitle("Settings")
        }
        .listStyle(InsetGroupedListStyle())
    }
}
