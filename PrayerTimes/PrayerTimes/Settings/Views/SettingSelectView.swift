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
                    ForEach(Method.allCases, id: \.hashValue) { item in
                        if item.index != 6 {
                            Text(item.toString)
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
