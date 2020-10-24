//
//  PrayerIconView.swift
//  PrayerTimes
//
//  Created by user on 24/10/2020.
//

import SwiftUI

struct PrayerIconView: View {
    
    let prayerIconName: String
    
    var body: some View {
        if prayerIconName == Icon.fajr.rawValue {
            Image(prayerIconName).font(Font.system(size: 23))
//                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        } else {
            Image(systemName: prayerIconName).font(Font.system(size: 23))
//                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}
