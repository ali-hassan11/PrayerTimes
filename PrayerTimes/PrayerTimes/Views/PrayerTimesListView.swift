//
//  PrayerTimeRowView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesListView: View {
    
    @Binding var prayers: [Prayer]
    
    var body: some View {
        
        VStack {
            ForEach(prayers) { prayer in
                //Extract into PrayerTimeCell
                HStack {
                    Text(prayer.name)
                        .font(.title3).fontWeight(.medium)
                    Spacer()
                    if prayer.isNextPrayer {
                        Text("in 1 hour 24 mins")
                            .font(.subheadline)
                            .opacity(0.9)
                    }
                    Spacer()
                    Text("\(prayer.formattedTime)")
                        .font(.title3).fontWeight(.medium)
                    Image(systemName: "bell.fill")
                        .padding(.leading, 20)
                }
                .padding(.all, 20)
                .background(prayer.isNextPrayer ? Color.init(.systemPink) : Color.init(.tertiarySystemBackground))
                .cornerRadius(5)
                .foregroundColor(prayer.isNextPrayer ? Color.init(.white) : Color.init(.label).opacity(0.8))
                .shadow(radius: 0.1)
            }
        }
    }
}

struct PrayerTimesListView_Previews: PreviewProvider {
    
    @State static var prayers = PreviewData().PREVIEW_PRAYERS
    
    static var previews: some View {
        PrayerTimesListView(prayers: $prayers)
    }
}
