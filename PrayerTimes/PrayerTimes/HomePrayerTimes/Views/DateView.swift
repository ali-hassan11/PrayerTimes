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
                viewModel.minusOneDay()
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
                
                DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .labelsHidden()
            }
            Spacer()
            Button(action: {
                viewModel.plusOneDay()
            }) {
                Image(systemName: "chevron.forward")
                    .font(Font.system(size: 25, weight: .semibold))
            }
            .padding(.all, 20)
        }
        .frame(minHeight: 110)
    }
}

//struct DateView_Previews: PreviewProvider {
//    @State static var viewModel = PreviewData().prayerTimeListViewModel
//    static var previews: some View {
//        DateView(viewModel: viewModel)
//    }
//}
