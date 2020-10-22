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
                    case .loaded:
                        
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

                    case .failed(let failure):

                        switch failure {
                        
                        case Failure.noInternet:
                            
                            ErrorView(text: "Failed to load prayer times, please check your internet connection and try again",
                                      button: .retry,
                                      action: { viewModel.retryFetchData() })
                            
                        case Failure.locationDisabled:
                            
                            ErrorView(text: "Please enable location usage in your phone's settings so that we can find the prayer times for your area",
                                      button: .goToSettings,
                                      action: {
                                        if let url = URL(string: UIApplication.openSettingsURLString) {
                                            UIApplication.shared.open(url, options: [:]) { _ in }
                                        }
                                      })
                            
                        case Failure.geoCodingError:
                            
                            ErrorView(text: "Please enable location usage in your phone's settings so that we can find the prayer times for your area",
                                      button: .ok,
                                      action: { viewModel.retryFetchData() })
                        }
                        
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
