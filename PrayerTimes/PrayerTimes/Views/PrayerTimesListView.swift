//
//  PrayerTimeRowView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesListView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.prayers) { prayer in
                PrayerTimeCell(prayer: prayer)
            }
        }
    }
}


struct PrayerTimesListView_Previews: PreviewProvider {
    
    @State static var prayersListViewModel = PreviewData().prayerTimeListViewModel
    
    static var previews: some View {
        PrayerTimesListView(viewModel: prayersListViewModel)
    }
}
