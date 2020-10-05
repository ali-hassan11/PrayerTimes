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
            .padding(.all, 20)
            Spacer()
            VStack {
                if viewModel.isToday(date: viewModel.date) {
                    Text("Today")
                        .font(Font.headline)
                        .foregroundColor(Color(UIColor.systemPink)).opacity(0.9)
                }
                Text(viewModel.hijriDate)
                    .font(Font.system(size: 24, weight: .semibold))
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(UIColor.label))
                Text(viewModel.gregorianDate).font(.headline).lineLimit(1).minimumScaleFactor(0.4)
                    .font(Font.system(size: 20, weight: .medium))
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(UIColor.label)).opacity(0.8)
            }
            Spacer()
            Button(action: {
                viewModel.fetchData(date: viewModel.date.plusOneDay)
            }) {
                Image(systemName: "chevron.forward")
                    .font(Font.system(size: 25, weight: .semibold))
            }
            .padding(.all, 20)
        }
        .frame(minHeight: 110)
    }
}

struct DateView_Previews: PreviewProvider {
    @State static var viewModel = PreviewData().prayerTimeListViewModel
    static var previews: some View {
        DateView(viewModel: viewModel)
    }
}
