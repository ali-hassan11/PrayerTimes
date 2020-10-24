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
                VStack(alignment: .leading) {
                    Text("Next:")
                        .font(Font.system(size: 18, weight: .medium))
                    Text("Maghrib")
                        .font(Font.system(size: 20, weight: .light))
                    Text("05:31")
                        .font(Font.system(size: 45, weight: .medium)).minimumScaleFactor(0.6)
                }
                .padding(10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        })
    }
}
