//
//  PrayerTimesHomeViewModel.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

class PrayerTimesHomeViewModel: ObservableObject {
    
    @Published var prayers: [Prayer] = []
    
    init() {
       fetchData()
    }
    
    func fetchData() {
        let prayerTimesConfiguration = PrayerTimeConfiguration(timestamp: "00000000",
                                                               coordinates: .init(latitude: "53.5228", longitude: "1.1285"),
                                                               method: .muslimWorldLeague,
                                                               school: .shafi)
        
        guard let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimesConfiguration) else { return }
        
        Service.shared.fetchPrayerTimes(url: url) { [weak self] result in
            
            switch result {
            case .success(let prayerTimesResponse):
                
                var prayerTimes = [Prayer]()
                
                for(prayerName,prayerTime) in prayerTimesResponse.prayerTimesData.timings {
                    let prayer = Prayer(name: prayerName, time: Date(), formattedTime: prayerTime, isNextPrayer: false)
                    prayerTimes.append(prayer)
                }
                
                DispatchQueue.main.async {
                    self?.prayers = prayerTimes
                }
                                
            case .failure(let error):
                print(error)
            }
        }
    }
}
