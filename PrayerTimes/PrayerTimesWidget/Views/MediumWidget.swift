//
//  MediumWidget.swift
//  PrayerTimes
//
//  Created by user on 22/10/2020.
//

import SwiftUI

struct MediumWidget: View {
    
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
                    HeaderView(family: .medium, hirjiDate: hijriDate, gregorianDate: gregorianDate)
                        .padding(.bottom, 3)
                    Spacer()

                    MediumHorizontalPrayerList(prayers: prayers)
                }
                .padding()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .foregroundColor(.white)
        })
    }
}

enum WidgetFamily { case small, medium, large }

struct HeaderView: View {
    
    let family: WidgetFamily
    let hirjiDate: String
    let gregorianDate: String
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                Text(hirjiDate)
                    .font(Font.system(size: family == .small ? 16 : family == .medium ? 18 : 24 , weight: .semibold))
                
                Text(gregorianDate)
                    .font(Font.system(size: family == .small ? 14 : family == .medium ? 14 : 16, weight: .medium))
            }
            Spacer()
        }
        
    }
}

struct MediumHorizontalPrayerList: View {
    
    let prayers: [Prayer]
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            ForEach(prayers) { prayer in
                
                if prayer.name != "Fajr" && prayer.name != "Sunrise" {
                    Spacer()
                }
                
                if prayer.name != "Sunrise" {
                    VStack {
                        Text(prayer.name)
                            .lineLimit(1)
                            .font(Font.system(size: 15, weight: .regular))
                            .opacity(0.9)
                            .foregroundColor(.white)
                        
                        Spacer()
                                
                        prayer.name == "Fajr" ?
                            Image(prayer.icon.rawValue)
                            .font(Font.system(size: 23)) :
                            Image(systemName: prayer.icon.rawValue)
                            .font(Font.system(size: 23))
                        
                        Spacer()
                        
                        Text(prayer.formattedTime)
                            .lineLimit(1)
                            .font(Font.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
