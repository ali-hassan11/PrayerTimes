
import Foundation

struct Prayer: Identifiable, Equatable {
    
    let id = UUID()
    let name: String
    let prayerDateString: String ///Format: dd-MM-yyyy
    let formattedTime: String ///Format: /HH:mm
    var isNextPrayer: Bool
    var hasPassed: Bool
    let icon: Icon
    
    init(name: String, prayerDateString: String, formattedTime: String, isNextPrayer: Bool = false, hasPassed: Bool, icon: Icon) {
        self.name = name
        self.prayerDateString = prayerDateString
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
        self.hasPassed = hasPassed
        self.icon = icon
    }
    
    static func == (lhs: Prayer, rhs: Prayer) -> Bool {
        lhs.name == rhs.name &&
            lhs.formattedTime == rhs.formattedTime &&
            lhs.prayerDateString == rhs.prayerDateString
    }
}
