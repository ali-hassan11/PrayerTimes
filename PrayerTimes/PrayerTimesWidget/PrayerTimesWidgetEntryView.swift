//
//  PrayerTimesWidgetEntryView.swift
//  PrayerTimesWidgetExtension
//
//  Created by user on 22/10/2020.
//

import SwiftUI

struct PrayerTimesWidgetEntryView: View {
    
    let entry: Provider.Entry
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        HStack {
            switch family {
            
            case .systemSmall:
                SmallWidget(entry: entry)
                
            case .systemMedium:
                MediumWidget(entry: entry)
                
            case .systemLarge:
                LargeWidget(entry: entry)
                
            default:
                Text("Dunno")
            
            }
        }
    }
}


