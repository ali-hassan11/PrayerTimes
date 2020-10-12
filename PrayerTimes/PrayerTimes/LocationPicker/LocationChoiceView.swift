//
//  LocationChoiceView.swift
//  PrayerTimes
//
//  Created by user on 12/10/2020.
//

import SwiftUI

struct LocationChoiceView: View {
    
    @Binding var isLocationPresented: Bool
    @State var isSearchPresented: Bool = false
    @Binding var date: Date
    
    var body: some View {
        List {
            Button("Use my location") {
               print("Locate me")
            }
            Button("Search") {
                isSearchPresented.toggle()
            }
            .sheet(isPresented: $isSearchPresented) {
                LocationPicker(date: $date, isLocationPresented: $isLocationPresented)
            }
        }
        
    }
}
