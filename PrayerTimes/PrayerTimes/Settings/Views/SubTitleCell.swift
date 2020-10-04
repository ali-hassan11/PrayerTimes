//
//  SubTitleCell.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

struct SubTitleCell: View {
    
    var title: String
    var subTitle: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.body)
                Text(subTitle).font(.footnote).foregroundColor(Color.init(.label)).opacity(0.7)
            }
            Spacer()
            Image(systemName: imageName)
                .foregroundColor(Color.init(.systemPink))
        }
    }
}
