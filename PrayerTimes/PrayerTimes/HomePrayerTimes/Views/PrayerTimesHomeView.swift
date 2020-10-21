//
//  ContentView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesHomeView: View {
    
    @ObservedObject var viewModel: PrayerTimeListViewModel
    @Binding var colorScheme: Color
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationView {
            
            Color(.systemGroupedBackground).overlay(
                VStack(spacing: 16) {
                    
                    switch (viewModel.stateManager.state) {
                    case (.loaded):
                        
                        Spacer()
                        DateView(viewModel: viewModel, colorScheme: $colorScheme)
                            .cornerRadius(25)
                        
                        HStack {
                            Spacer()
                            Text("Select date:")
                            DatePicker("", selection: $viewModel.date, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                                .foregroundColor(Color(.secondarySystemGroupedBackground))
                            
                            Spacer()

                        }
                        
                        PrayerTimesListView(viewModel: viewModel, colorScheme: $colorScheme)
                            .cornerRadius(25)
                        Spacer()

                    case (.failed):
                        
                        ErrorView(text: "Failed to load prayer times, please check your internet connection and try again",
                                  hasRetryButton: true,
                                  action: { viewModel.retryFetchData() })
                        
                    default :
                        
                        ProgressView()//Add time out
                    
                    }
                    
                }
                .animation(.linear)
                .padding(.horizontal, 20)
                .navigationBarTitle(viewModel.locationName, displayMode: .inline)
            )
            
        }
    }
}
