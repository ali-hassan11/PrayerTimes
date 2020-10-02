//
//  NextPrayerView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct NextPrayerView: View {
    
    @Binding var prayer: Prayer?

    var body: some View {
                
            HStack {
                Text("Next Prayer:")
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text(prayer?.name ?? "")
                    Text(prayer?.formattedTime ?? "")
                }
            }
            .padding(.all, 20)
            .frame(height: 100, alignment: .center)
            .background(Color.blue)
    }
}

struct NextPrayerView_Previews: PreviewProvider {
    
    @State static var prayer: Prayer? = Prayer(name: "Fajr", time: Date(), formattedTime: "Time", isNextPrayer: true)
    
    static var previews: some View {
        NextPrayerView(prayer: $prayer)
    }
}
