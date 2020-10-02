//
//  ContentView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesHomeView: View {
    
    @ObservedObject var viewModel: PrayerTimesHomeViewModel
    
    var body: some View {
                
        VStack() {
            DateView(hirjiDate: hijriDate,
                     gregorianDate: gregorianDate,
                     isHijri: true)
            Spacer()
            NextPrayerView()
            PrayerTimesList(prayers: $viewModel.prayers)
            Spacer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimesHomeView(viewModel: PrayerTimesHomeViewModel())
    }
}

//DateViewModel - Format both dates
let hijriDate = "13 Safar, 1442"
let gregorianDate = "01 October 2020"


//PrayerTimesViewModel, to only give relevant info, ie. name & time
//& to calculate next prayer
let nextPrayer: Prayer = Prayer(name: "Asr", time: Date(), formattedTime: "20:00")

//let prayers: [Prayer] = [Prayer(name: "Fajr", time: Date(), formattedTime: "00:00"),
//                         Prayer(name: "Dhuhr", time: Date(), formattedTime: "10:00"),
//                         Prayer(name: "Asr", time: Date(), formattedTime: "20:00", isNextPrayer: true),
//                         Prayer(name: "Maghrib", time: Date(), formattedTime: "30:00"),
//                         Prayer(name: "Isha", time: Date(), formattedTime: "40:00")]
//
//
//
