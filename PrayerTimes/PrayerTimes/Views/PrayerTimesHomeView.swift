//
//  ContentView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesHomeView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @EnvironmentObject var settingsConfiguration: SettingsConfiguration
    
    var body: some View {
        
        NavigationView {
            Color.init(.secondarySystemBackground).overlay(
                VStack() {
                    Spacer()
                    DateView(hijriDate: $viewModel.hijriDate, gregorianDate: $viewModel.gregorianDate)
                    Spacer()
                    PrayerTimesListView(viewModel: viewModel)
                        .cornerRadius(25)
                    Spacer()
                }
                .animation(.spring())
                .padding(.horizontal, 20)
            )
            .navigationBarTitle("Hatfield, UK", displayMode: .inline)
            .navigationBarItems(leading: Button(action: safariPressed, label: {
                Image(systemName: "safari")
            }), trailing: Button(action: calendarPressed, label: {
                Image(systemName: "calendar")
            }))
        }
        .onAppear(perform: {
            viewModel.fetchData(date: Date())
        })
    }
    
    func safariPressed() {
        print("safariPressed")
//        viewModel.fetchData(date: viewModel.date.minus24Hours)
    }
    
    func calendarPressed() {
        print("calendar")
//        viewModel.fetchData(date: viewModel.date.plus24Hours)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PrayerTimeListViewModel(date: Date())
        PrayerTimesHomeView(viewModel: viewModel)
    }
}
