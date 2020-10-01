//
//  NextPrayerView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct NextPrayerView: View {
    var body: some View {
           
            HStack {
                Text("Next Prayer:")
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Asr")
                    Text("20:00")
                }
            }
            .padding(.all, 20)
            .frame(height: 100, alignment: .center)
            .background(Color.blue)
    }
}

struct NextPrayerView_Previews: PreviewProvider {
    static var previews: some View {
        NextPrayerView()
    }
}
