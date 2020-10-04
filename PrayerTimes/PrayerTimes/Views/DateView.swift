//
//  DateView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct DateView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel

    var body: some View {
        
        HStack {
            Button(action: {
                viewModel.fetchData(date: viewModel.date.minusOneDay)
            }) {
                Image(systemName: "chevron.backward")
            }.padding()
            VStack {
                Text(viewModel.hijriDate).font(.largeTitle).multilineTextAlignment(.center)
                Text(viewModel.gregorianDate).font(.headline).multilineTextAlignment(.center)
            }
            Button(action: {
                viewModel.fetchData(date: viewModel.date.plusOneDay)
            }) {
                Image(systemName: "chevron.forward")
            }.padding()
        }
    }
}

struct DateView_Previews: PreviewProvider {
    @State static var viewModel = PreviewData().prayerTimeListViewModel
    static var previews: some View {
        DateView(viewModel: viewModel)
    }
}
