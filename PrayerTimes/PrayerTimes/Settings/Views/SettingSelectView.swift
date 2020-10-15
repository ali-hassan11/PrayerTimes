//
//  SettingSelectView.swift
//  PrayerTimes
//
//  Created by user on 12/10/2020.
//

import SwiftUI

struct SettingSelectView: View {
    
    enum SettingType {
        case method
        case school
        case latitudeAdjustmentMethod
    }

    var type: SettingType
    var title: String
    
    var body: some View {
        
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
                    ForEach(School.allCases, id: \.hashValue) { item in
                        Text(item.toString)
                    }
                    
                case .latitudeAdjustmentMethod:
                    ForEach(LatitudeAdjustmentMethod.allCases, id: \.hashValue) { item in
                        Text(item.toString)
                    }
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
        }
    }
}
