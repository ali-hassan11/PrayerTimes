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
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationView {
            
            Color(.systemBackground).overlay(
                VStack(spacing: 16) {
                    
                    switch (viewModel.stateManager.state) {
                    case (.loaded):
                        
                        Spacer()
                        DateView(viewModel: viewModel)
                            .cornerRadius(25)
                        
                        HStack {
                            Spacer()
                            Text("Select date:")
                            DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                            
                            Spacer()

                        }
                        
                        PrayerTimesListView(viewModel: viewModel)
                            .cornerRadius(25)
                        Spacer()

                    case (.failed):
                        
                        ErrorView(action: { viewModel.retryFetchData() })
                        
                    default :
                        
                        ProgressView()//Add time out
                    
                    }
                    
                }
                .animation(.linear)
                .padding(.horizontal, 20)
                .navigationBarTitle(viewModel.locationName, displayMode: .inline)
            )
            
        }
//        .gesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
//                    .onEnded({ value in
//                        if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
//                            viewModel.plusOneDay()
//                        }
//                        if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
//                            viewModel.minusOneDay()
//                        }
//                    }))
    }
}
