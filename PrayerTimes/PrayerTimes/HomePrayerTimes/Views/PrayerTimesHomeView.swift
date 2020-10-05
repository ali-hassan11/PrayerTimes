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
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Color.init(.secondarySystemBackground).overlay(
                
                VStack() {
                    
                    switch (viewModel.stateManager.state) {
                    case (.loaded):

                        Spacer()
                        DateView(viewModel: viewModel)
                        Spacer()
                        PrayerTimesListView(viewModel: viewModel)
                            .cornerRadius(25)
                            .shadow(color: Color(UIColor.systemGroupedBackground.withAlphaComponent(0.5)), radius: 2)
                        Spacer()
                        
                    case (.failed):
                        
                        
                        Text("Failed to load prayer times, please check your internet connection and try again")
                            .font(Font.body)
                            .multilineTextAlignment(.center)
                            .padding(.all, 20)
                        Button(action: { viewModel.fetchData(date: viewModel.date) }) {
                            Image(systemName: "arrow.clockwise")
                                .font(Font.system(size: 25, weight: .semibold))
                        }
                        
                    default :
                        ProgressView()//Add time out
                    }
                    
                }
                .animation(.linear)
                .padding(.horizontal, 20)
                
            )
            .navigationBarTitle("Hatfield, UK", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {}, label: {
                Image(systemName: "safari")
            }), trailing: Button(action: {}, label: {
                Image(systemName: "calendar")
            }))
        }
        .onAppear(perform: {
            viewModel.fetchData(date: Date())
        })
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewModel = PrayerTimeListViewModel
//        PrayerTimesHomeView(viewModel: viewModel)
//    }
//}
