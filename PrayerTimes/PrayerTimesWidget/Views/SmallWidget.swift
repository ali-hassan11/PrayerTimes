//
//  SmallWidget.swift
//  PrayerTimes
//
//  Created by user on 22/10/2020.
//

import SwiftUI

struct SmallWidget: View {
    
    let entry: PrayerTimeEntry
    
    var body: some View {
        GeometryReader.init(content: { geometry in
            ZStack {
                linearGradient(colorScheme: .init(.systemPink))
                VStack {
                    
                    
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        })
    }
}
