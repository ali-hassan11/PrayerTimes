//
//  PrayerTimeCell.swift
//  PrayerTimes
//
//  Created by user on 03/10/2020.
//

import SwiftUI

struct PrayerTimeCell:  View {

    var prayer: Prayer
    var viewModel: PrayerTimeListViewModel
    @Binding var colorScheme: Color
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack(spacing: 0) {
            if prayer.name != PrayerName.fajr.capitalized() {
                Divider()
            }
            HStack {
                PrayerIconView(prayerIconName: prayer.icon.rawValue)
                    .frame(width: 30)
                
                Text(prayer.name)
                    .font(.title3).fontWeight(.medium)
                
                Spacer()
                
                if prayer.isNextPrayer {
                    CountdownView(timeRemaining: viewModel.timeRemainingString)
                    Spacer()
                }
                
                Text(prayer.formattedTime)
                    .font(.title3).fontWeight(.medium)
            }
            .padding(.all, 20)
            .background(cellBackground)
            .foregroundColor(prayer.isNextPrayer ? Color(UIColor.white) : Color(UIColor.label).opacity(0.8))
            .onReceive(timer) { _ in
                viewModel.updateTimeRemaining()
            }
        }
    }
    
    var cellBackground: AnyView {
        if prayer.isNextPrayer {
            return AnyView(linearGradient(colorScheme: colorScheme))
        } else {
            return AnyView(Color(UIColor.secondarySystemGroupedBackground))
        }
    }
}
