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
            .navigationBarItems(leading: Button(action: locatePressed, label: {
                Image(systemName: "safari")
            }), trailing: Button(action: compassPressed, label: {
                Image(systemName: "calendar")
            }))
        }
        .onAppear(perform: {
            viewModel.fetchData(date: Date())
        })
    }
    
    func locatePressed() {
        print("locatePressed")
    }
    
    func compassPressed() {
        print("compassPressed")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PrayerTimeListViewModel(date: Date())
        PrayerTimesHomeView(viewModel: viewModel)
    }
}
