
import Foundation

struct Prayer: Identifiable {

    let id = UUID()
    let name: String
    let timestamp: Date
    let formattedTime: String
    let isNextPrayer: Bool
    
    init(name: String, time: Date, formattedTime: String, isNextPrayer: Bool = false) {
        self.name = name
        self.timestamp = time
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
    }
}
