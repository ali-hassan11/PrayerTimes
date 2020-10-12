//
//  SettingSelectView.swift
//  PrayerTimes
//
//  Created by user on 12/10/2020.
//

import SwiftUI

struct SettingSelectView: View {
    
    var type: SettingType
    
    var body: some View {
        
        switch type {
        case .method:
            List {
                ForEach(Method.allCases, id: \.hashValue) { item in
                    if item.index != 6 {
                        Text(item.toString)
                    }
                }
            }
        case .school:
            List {
                ForEach(School.allCases, id: \.hashValue) { item in
                    Text(item.toString)
                }
            }
        case .highLatitudeAdjustment:
            Text("Hi")
        }
        
        
    }
}



enum SettingType {
    case method
    case school
    case highLatitudeAdjustment
}
