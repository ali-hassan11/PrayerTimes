//
//  ErrorView.swift
//  PrayerTimes
//
//  Created by user on 21/10/2020.
//

import SwiftUI

struct ErrorView: View {
    
    let title: String
    let message: String
    let action: () -> Void
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
