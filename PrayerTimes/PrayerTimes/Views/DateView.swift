//
//  DateView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct DateView: View {
    
    @Binding var hijriDate: String
    @Binding var gregorianDate: String

    var body: some View {
        VStack {
            Text(hijriDate).font(.largeTitle)
            Text(gregorianDate).font(.headline)
        }
    }
}

//struct DateView_Previews: PreviewProvider {
//    @State static var formattedDate: String = "Test Date"
//    static var previews: some View {
//        DateView(formattedDate: $formattedDate)
//    }
//}
