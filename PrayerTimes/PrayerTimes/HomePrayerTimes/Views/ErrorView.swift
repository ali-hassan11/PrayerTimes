//
//  ErrorView.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

struct ErrorView: View {
    
    var action: () -> Void
    
    var body: some View {
        Text("Failed to load prayer times, please check your internet connection and try again")
            .font(Font.body)
            .multilineTextAlignment(.center)
            .padding(.all, 40)
        Button(action: { action() }) {
            Image(systemName: "arrow.clockwise")
                .font(Font.system(size: 25, weight: .semibold))
        }
    }
}
