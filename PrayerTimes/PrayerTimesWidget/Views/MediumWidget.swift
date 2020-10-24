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
        GeometryReader.init(content: { geometry in
            ZStack {
                
                linearGradient(colorScheme: .init(.systemPink))
                
                VStack(alignment: .leading) {
                    HeaderView(family: .medium, hirjiDate: "28 Muharram, 1442", gregorianDate: "22 October 2020")
                        .padding(.bottom, 3)
                    Spacer()

                    MediumHorizontalPrayerList(prayers: entry.prayerTimes)
                }
                .padding()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .foregroundColor(.white)
        })
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget(entry: PrayerTimeEntry(prayerTimes: []))
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
