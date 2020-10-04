
import Foundation

struct Prayer: Identifiable, Equatable {

    let id = UUID()
    let name: String
    let formattedTime: String
    let isNextPrayer: Bool
    
    init(name: String, formattedTime: String, isNextPrayer: Bool = false) {
        self.name = name
        self.formattedTime = formattedTime
        self .isNextPrayer = isNextPrayer
    }
}
