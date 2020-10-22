
import Foundation

struct Prayer: Identifiable, Equatable {

    let id = UUID()
    let name: String
    let prayerDateString: String
    let formattedTime: String
    var isNextPrayer: Bool
    var hasPassed: Bool
    
    init(name: String, prayerDateString: String, formattedTime: String, isNextPrayer: Bool = false, hasPassed: Bool) {
        self.name = name
        self.prayerDateString = prayerDateString
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
        self.hasPassed = hasPassed
    }
}
