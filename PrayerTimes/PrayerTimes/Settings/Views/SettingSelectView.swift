//
//  SettingSelectView.swift
//  PrayerTimes
//
//  Created by user on 12/10/2020.
//

import SwiftUI

struct SettingSelectView: View {
    
    @Binding var isOptionSelectViewPresented: Bool
    
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
                                isOptionSelectViewPresented.toggle()
                                // Reload/Trigger reload of prayer times
                            }) {
                                Text(method.toString)
                            }
                            .foregroundColor(Color.init(.label))
                        }
                    }
                case .school:
                    ForEach(School.allCases, id: \.hashValue) { school in
                        Text(school.toString)
                            .onTapGesture(perform: {
                                // Save
                                isOptionSelectViewPresented.toggle()
                                // Reload/Trigger reload of prayer times
                            })
                    }
                    
                case .latitudeAdjustmentMethod:
                    ForEach(LatitudeAdjustmentMethod.allCases, id: \.hashValue) { latitudeMethod in
                        Text(latitudeMethod.toString)
                            .onTapGesture(perform: {
                                // Save
                                isOptionSelectViewPresented.toggle()
                                // Reload/Trigger reload of prayer times
                            })
                    }
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
}
