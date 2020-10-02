
import Foundation

struct Prayer: Identifiable {

    let id = UUID()
    let name: String
    let timestamp: Date
    let formattedTime: String
    let isNextPrayer: Bool
    
    init(name: String, timestamp: Date, formattedTime: String, isNextPrayer: Bool = false) {
        self.name = name
        self.timestamp = timestamp
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
    }
}
