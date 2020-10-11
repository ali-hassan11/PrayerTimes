//
//  SettingsView.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    ChooseColorCell(title: "Color Scheme", action: {})
                }
                
                Section {
                    SubTitleCell(title: "Location",
                                 subTitle: "Hatfield",
                                 imageName: "chevron.forward",
                                 action: {})
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
