//
//  ErrorView.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

enum ErrorButton {
    case ok
    case retry
}

struct ErrorView: View {
    
    let text: String
    let button: ErrorButton?
    var action: () -> Void
    
    var body: some View {
        Text(text)
            .font(Font.body)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
            .padding(.bottom, 18)
        
        if let button = self.button {
            
            switch button {
            
            case .ok:
                
                Button(action: { action() }) {
                    Text("OK")
                        .font(Font.system(size: 19, weight: .semibold))
                }
                
            case .retry:
                
                Button(action: { action() }) {
                    Image(systemName: "arrow.clockwise")
                        .font(Font.system(size: 25, weight: .semibold))
                }
                
            }
        }
    }
}
