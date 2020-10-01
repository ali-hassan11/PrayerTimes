//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

struct PrayerTimesHomeViewModel {
    
    init() {
        let prayerTimesConfiguration = PrayerTimeConfiguration(timestamp: "00000000",
                                                               coordinates: .init(latitude: "53.5228", longitude: "1.1285"),
                                                               method: .muslimWorldLeague,
                                                               school: .shafi)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else { return }
        
        Service.shared.fetchPrayerTimes(url: url) { (result) in
            print(result)
        }
    }
    
}
