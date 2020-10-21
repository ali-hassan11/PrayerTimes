//
//  ErrorView.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

struct ErrorView: View {
    
    let text: String
    let hasRetryButton: Bool
    var action: () -> Void
    
    var body: some View {
        Text(text)
            .font(Font.body)
            .multilineTextAlignment(.center)
            .padding(.all, 40)
        
        if hasRetryButton {
            Button(action: { action() }) {
                Image(systemName: "arrow.clockwise")
                    .font(Font.system(size: 25, weight: .semibold))
            }
        }
    }
}
