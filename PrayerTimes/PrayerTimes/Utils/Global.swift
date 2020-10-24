//
//  Global.swift
//  PrayerTimes
//
//  Created by user on 22/10/2020.
//

import SwiftUI

func linearGradient(colorScheme: Color) -> LinearGradient {
    LinearGradient(gradient: Gradient(colors: [Color("CustomBlue"), Color("CustomPurple")]),
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing)
}
