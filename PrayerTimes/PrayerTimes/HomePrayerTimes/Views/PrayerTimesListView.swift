//
//  PrayerTimeRowView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesListView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @Binding var colorScheme: Color
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(viewModel.prayers) { prayer in
                PrayerTimeCell(prayer: prayer, viewModel: viewModel, colorScheme: $colorScheme)
                Divider()
            }
        }
    }
}
