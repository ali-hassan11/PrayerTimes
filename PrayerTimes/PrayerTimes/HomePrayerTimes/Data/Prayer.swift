
import Foundation

struct Prayer: Identifiable, Equatable {

    let id = UUID()
    let name: String
    let prayerDateString: String
    let formattedTime: String
    var isNextPrayer: Bool
    
    init(name: String, prayerDateString: String, formattedTime: String, isNextPrayer: Bool = false) {
        self.name = name
        self.prayerDateString = prayerDateString
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
    }
}
