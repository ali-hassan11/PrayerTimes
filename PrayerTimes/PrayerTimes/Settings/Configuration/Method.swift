//
//  Method.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation
//protocol SettingOption: CaseIterable {
//    var index: Int { get }
//    var toString: String { get }
//}

enum Method: Int, CaseIterable {
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
    
    var index:  Int {
        return rawValue
    }
    
    var toString: String {
        switch self {
        case .shiaIthnaAnsari: return "Shia Ithna-Ansari"
        case .universityOfIslamicSciencesKarachi: return "University of Islamic Sciences, Karachi"
        case .islamicSocietyOfNorthAmerica: return "Islamic Society of North America"
        case .muslimWorldLeague: return "Muslim World League"
        case .ummAlQuraUniversityMakkah: return "Umm Al-Qura University, Makkah"
        case .egyptianGeneralAuthorityOfSurvey: return "Egyptian General Authority of Survey"
        case .DONT_USE: return ""
        case .InstituteOfGeophysicsUniversityOfTehran: return "Institute of Geophysics, University of Tehran"
        case .gulfRegion: return "Gulf Region"
        case .kuwait: return "Kuwait"
        case .qatar: return "Qatar"
        case .majlisUgamaIslamSingapuraSingapore: return "Majlis Ugama Islam Singapura, Singapore"
        case .unionOrganizationIslamicDeFrance: return "Union Organization islamic de France"
        case .siyanetIsleriBaskanligiTurkey: return "Diyanet İşleri Başkanlığı, Turkey"
        case .spiritualAdministrationOfMuslimsOfRussia: return "Spiritual Administration of Muslims of Russia"
        }
    }
}
