
import Foundation

struct Prayer: Identifiable {

    let id = UUID()
    let name: PrayerName
    let time: Date
    let formattedTime: String
    let isNextPrayer: Bool
    
    init(name: PrayerName, time: Date, formattedTime: String, isNextPrayer: Bool = false) {
        self.name = name
        self.time = time
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
    }
}
