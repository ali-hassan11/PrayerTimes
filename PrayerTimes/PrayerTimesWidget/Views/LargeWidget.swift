//
//  LargeWidget.swift
//  PrayerTimes
//
//  Created by user on 22/10/2020.
//

import SwiftUI

struct LargeWidget: View {
    
    let entry: PrayerTimeEntry
    
    var body: some View {
        GeometryReader.init(content: { geometry in
            ZStack {
                linearGradient(colorScheme: entry.colorScheme)
                
                VStack(alignment: .leading) {
                    HeaderView(family: .large, hirjiDate: "28 Muharram, 1442", gregorianDate: "22 October 2020")
                        .padding(.bottom, 4)
                    
                    Spacer()
                    
                    VStack {
                        
                        ForEach(entry.prayerTimes) { prayer in
                            
                            HStack {
                                
                                PrayerIconView(prayerIconName: prayer.icon.rawValue)
                                    .font(Font.system(size: 23))
                                    .frame(width: 30)
                                    .padding(.trailing, 2)
                                
                                Text(prayer.name)
                                    .font(Font.system(size: 21, weight: .light))
                                
                                Spacer()
                                
                                Text(prayer.formattedTime)
                                    .font(Font.system(size: 23, weight: .regular))
                                
                            }
                            prayer.name != PrayerName.isha.capitalized() ? Spacer() : nil
                            prayer.name != PrayerName.isha.capitalized() ? Rectangle()
                                .frame(height: 0.5)
                                .foregroundColor(.white)
                                .opacity(0.5): nil
                        }
                        
                    }
                }
                .padding()
                .foregroundColor(.white)

            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        })
    }
}

