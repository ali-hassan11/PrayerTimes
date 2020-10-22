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
        HStack {
            Text(prayer.name)
                .font(.title3).fontWeight(.medium)
            Spacer()
            if prayer.isNextPrayer {
                VStack {
                    Text("Begins in:")
                    Text(viewModel.timeRemainingString)
                }
                .font(.subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                Spacer()
            }
            Text("\(prayer.formattedTime)")
                .font(.title3).fontWeight(.medium)
        }
        .padding(.all, 20)
        .background(prayer.isNextPrayer ? colorScheme : prayer.hasPassed ? colorScheme.opacity(0.25) : Color(UIColor.secondarySystemGroupedBackground))
        .foregroundColor(prayer.isNextPrayer ? Color(UIColor.white) : Color(UIColor.label).opacity(0.8))
        .onReceive(timer) { _ in
            viewModel.updateTimeRemaining()
        }
    }
}
