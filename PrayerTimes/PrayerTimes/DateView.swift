//
//  DateView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct DateView: View {
    
    let hirjiDate: String
    let gregorianDate: String
    
    let isHijri: Bool
    
    var body: some View {
        HStack {
            Text(isHijri ? hijriDate : gregorianDate)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(hirjiDate: "hijri date", gregorianDate: "gregorian date", isHijri: true)
    }
}
