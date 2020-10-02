//
//  DateView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct DateView: View {
    
    @Binding var formattedDate: String

    var body: some View {
        HStack {
            Text(formattedDate)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct DateView_Previews: PreviewProvider {
    @State static var formattedDate: String = "Test Date"
    static var previews: some View {
        DateView(formattedDate: $formattedDate)
    }
}
