//
//  SettingSelectView.swift
//  PrayerTimes
//
//  Created by user on 12/10/2020.
//

import SwiftUI

struct SettingSelectView: View {
    
    @Binding var isPresented: Bool
    @Binding var date: Date
    
    enum SettingType {
        case method
        case school
        case latitudeAdjustmentMethod
    }

    var type: SettingType
    var title: String
    
    var body: some View {
        
        // / //*** ANYTIME ONE OF THESE SETTINGS ARE CHANGED, MUST SAVE IT, THEN FETCH NEW PRAYER TIMES DATA... (AND RESET NOTIFICATIONS) ***\\ \ \\
        NavigationView {
            List {
                switch type {
                case .method:
                    ForEach(Method.allCases, id: \.hashValue) { method in
                        if method.index != 6 {
                            Button(action: {
                                SettingsConfiguration.shared.saveMethodSetting(method)
                                triggerFetchData()
                                isPresented.toggle()

                            }) {
                                Text(method.toString)
                            }
                            .foregroundColor(Color.init(.label))
                        }
                    }
                case .school:
                    ForEach(School.allCases, id: \.hashValue) { school in
                        Button(action: {
                            SettingsConfiguration.shared.saveSchoolSetting(school)
                            triggerFetchData()
                            isPresented.toggle()

                        }) {
                            Text(school.toString)
                        }
                        .foregroundColor(Color.init(.label))
                    }
                    
                case .latitudeAdjustmentMethod:
                    ForEach(LatitudeAdjustmentMethod.allCases, id: \.hashValue) { latitudeMethod in
                        Button(action: {
                            SettingsConfiguration.shared.saveLatitudeSetting(latitudeMethod)
                            triggerFetchData()
                            isPresented.toggle()

                        }) {
                            Text(latitudeMethod.toString)
                        }
                        .foregroundColor(Color.init(.label))
                    }
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
    
    private func triggerFetchData() {
        date = Date()
    }
}
