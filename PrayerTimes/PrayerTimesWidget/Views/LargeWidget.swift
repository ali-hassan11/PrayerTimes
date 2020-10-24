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
        
        let prayers = entry.viewModel.prayers
        let hijriDate = entry.viewModel.hijriDate
        let gregorianDate = entry.viewModel.gregorianDate
        let colorScheme = entry.viewModel.colorScheme
        
        GeometryReader.init(content: { geometry in
            ZStack {
                linearGradient(colorScheme: colorScheme)
                
                VStack(alignment: .leading) {
                    HeaderView(family: .large, hirjiDate: hijriDate, gregorianDate: gregorianDate)
                        .padding(.bottom, 4)
                    
                    Spacer()
                    
                    VStack {
                        
                        ForEach(prayers) { prayer in
                            
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

