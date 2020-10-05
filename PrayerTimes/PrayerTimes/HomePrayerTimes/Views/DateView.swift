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
                    .font(Font.system(size: 25, weight: .semibold))
            }
            .padding(.all, 25)
            
            VStack {
                if viewModel.isToday(date: viewModel.date) {
                    Text("Today")
                        .font(Font.subheadline)
                        .foregroundColor(Color(UIColor.systemPink)).opacity(0.8)
                }
                Text(viewModel.hijriDate).font(.largeTitle).lineLimit(1).minimumScaleFactor(0.5)
                Text(viewModel.gregorianDate).font(.headline).lineLimit(1).minimumScaleFactor(0.5)
            }
            
            Button(action: {
                viewModel.fetchData(date: viewModel.date.plusOneDay)
            }) {
                Image(systemName: "chevron.forward")
                    .font(Font.system(size: 25, weight: .semibold))
            }
            .padding(.all, 25)
        }
    }
}

struct DateView_Previews: PreviewProvider {
    @State static var viewModel = PreviewData().prayerTimeListViewModel
    static var previews: some View {
        DateView(viewModel: viewModel)
    }
}
