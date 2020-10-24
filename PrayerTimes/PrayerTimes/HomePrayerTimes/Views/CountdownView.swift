//
//  CountdownView.swift
//  PrayerTimes
//
//  Created by user on 24/10/2020.
//

import SwiftUI

struct CountdownView: View {
    
    let timeRemaining: String
    
    var body: some View {
        VStack {
            Text("Begins in:")
            Text(timeRemaining)
        }
        .font(.subheadline)
        .lineLimit(2)
        .multilineTextAlignment(.center)
        .minimumScaleFactor(0.5)
    }
}

