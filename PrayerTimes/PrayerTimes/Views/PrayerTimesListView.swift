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
                HStack {
                    Text(prayer.name)
                        .font(.title3).fontWeight(.medium)
                    Spacer()
                    Text("\(prayer.formattedTime)")
                        .font(.title3).fontWeight(.medium)
                    Image(systemName: "bell.fill")
                        .padding(.leading, 20)
                }
                .padding(.all, 18)
                .background(prayer.isNextPrayer ? Color.init(.systemPink) : Color.init(.systemBackground))
                .cornerRadius(5)
                .foregroundColor(prayer.isNextPrayer ? Color.init(.white) : Color.init(.label))
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
