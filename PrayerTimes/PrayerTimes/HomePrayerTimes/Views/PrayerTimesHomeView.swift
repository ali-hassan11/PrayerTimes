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
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        NavigationView {
            
            Color(.secondarySystemBackground).overlay(
                VStack() {
                    
                    switch (viewModel.stateManager.state) {
                    case (.loaded):
                        
                        Spacer()
                        DateView(viewModel: viewModel)
                            .padding(.bottom, 8)
                        PrayerTimesListView(viewModel: viewModel)
                            .cornerRadius(25)
                        Spacer()
                        
                    case (.failed):
                        
                        
                        Text("Failed to load prayer times, please check your internet connection and try again")
                            .font(Font.body)
                            .multilineTextAlignment(.center)
                            .padding(.all, 20)
                        Button(action: { viewModel.retryFetchData() }) {
                            Image(systemName: "arrow.clockwise")
                                .font(Font.system(size: 25, weight: .semibold))
                        }
                        
                    default :
                        ProgressView()//Add time out
                    }
                    
                }
                .animation(.linear)
                .padding(.horizontal, 20)
                .navigationBarTitle("Hatfield, UK", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: { }, label: {
                    Image(systemName: "safari")
                }))
            )
            
        }
        .gesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
                    .onEnded({ value in
                        if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                            viewModel.plusOneDay()
                        }
                        if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                            viewModel.minusOneDay()
                        }
                    }))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = PrayerTimeListViewModel
//        PrayerTimesHomeView(viewModel: viewModel)
//    }
//}
