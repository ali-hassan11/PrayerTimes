//
//  SettingSelectView.swift
//  PrayerTimes
//
//  Created by user on 12/10/2020.
//

import SwiftUI
import WidgetKit

struct SettingSelectView: View {
    
    @Binding var isPresented: Bool
    @Binding var date: Date
    @Binding var colorScheme: Color
    
    private let tickIconName = "checkmark.circle"
    
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
                    let currentMethod = SettingsConfiguration.shared.method
                   
                    ForEach(Method.allCases, id: \.hashValue) { method in
                    
                        if method.index != 6 {
                            Button(action: {
                                SettingsConfiguration.shared.saveMethodSetting(method)
                                isPresented.toggle()
                                triggerFetchData()
                            }) {
                                HStack{
                                    Text(method.toString)
                                    
                                    if method == currentMethod {
                                        Spacer()
                                        Image(systemName: tickIconName)
                                            .foregroundColor(colorScheme)
                                    }
                                }
                            }
                            .foregroundColor(Color.init(.label))
                        }
                    }
                case .school:
                    
                    let currentSchool = SettingsConfiguration.shared.school
                    
                    ForEach(School.allCases, id: \.hashValue) { school in
                        Button(action: {
                            SettingsConfiguration.shared.saveSchoolSetting(school)
                            isPresented.toggle()
                            triggerFetchData()
                        }) {
                            
                            HStack {
                                Text(school.toString)
                                
                                if school == currentSchool {
                                    Spacer()
                                    Image(systemName: tickIconName)
                                        .foregroundColor(colorScheme)
                                }
                            }
                        }
                        .foregroundColor(Color.init(.label))
                    }
                    
                case .latitudeAdjustmentMethod:
                    
                    let currentLatitude = SettingsConfiguration.shared.latitudeAdjustmentMethod
                    
                    ForEach(LatitudeAdjustmentMethod.allCases, id: \.hashValue) { latitudeMethod in
                        Button(action: {
                            SettingsConfiguration.shared.saveLatitudeSetting(latitudeMethod)
                            isPresented.toggle()
                            triggerFetchData()
                        }) {
                            HStack {
                                Text(latitudeMethod.toString)
                                
                                if latitudeMethod == currentLatitude {
                                    Spacer()
                                    Image(systemName: tickIconName)
                                        .foregroundColor(colorScheme)
                                }
                            }
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
