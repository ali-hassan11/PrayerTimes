//
//  ContentView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesHomeView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    
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
        print("qiblaPressed")
    }
    
    func calendarPressed() {
        print("calendar")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = PrayerTimeListViewModel
//        PrayerTimesHomeView(viewModel: viewModel)
//    }
//}
