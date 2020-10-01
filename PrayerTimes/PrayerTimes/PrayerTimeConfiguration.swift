//
//  PrayerTimeConfiguration.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

struct PrayerTimeConfiguration {
    let timestamp: String
    let coordinates: Coordinates
    let method: Method
    let school: School
}

struct Coordinates {
    let latitude: String
    let longitude: String
}

enum Method: Int {
    case shiaIthnaAnsari
    case universityOfIslamicSciencesKarachi
    case islamicSocietyOfNorthAmerica
    case muslimWorldLeague
    case ummAlQuraUniversityMakkah
    case egyptianGeneralAuthorityOfSurvey
    case DONT_USE
    case InstituteOfGeophysicsUniversityOfTehran
    case gulfRegion
    case kuwait
    case qatar
    case majlisUgamaIslamSingapuraSingapore
    case unionOrganizationIslamicDeFrance
    case siyanetIsleriBaskanligiTurkey
    case spiritualAdministrationOfMuslimsOfRussia
    
    func toString() -> String {
        return String(rawValue)
    }
}

enum School: Int {
    case shafi
    case hanafi
    
    func toString() -> String {
        return String(rawValue)
    }
}
