//
//  DateView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct DateView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @Binding var colorScheme: Color

    var body: some View {
        
        HStack {
            Button(action: {
                viewModel.minusOneDay()
            }) {
                Image(systemName: "chevron.backward")
                    .font(Font.system(size: 27, weight: .bold))
                    .accentColor(.white)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(spacing: 0) {
                if viewModel.isToday(date: viewModel.date) {
                    Text("TODAY")
                        .font(Font.headline).fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 12)
                }
                
                Text(viewModel.hijriDate)
                    .font(Font.system(size: 24, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.bottom, 12)
                    .padding(.top, viewModel.isToday(date: viewModel.date) ? 0 : 12)
            }
            
            Spacer()
            
            Button(action: {
                viewModel.plusOneDay()
            }) {
                Image(systemName: "chevron.forward")
                    .font(Font.system(size: 27, weight: .bold))
                    .accentColor(.white)
            }
            .padding(.horizontal, 20)
        }
        .background(colorScheme)
    }
}
