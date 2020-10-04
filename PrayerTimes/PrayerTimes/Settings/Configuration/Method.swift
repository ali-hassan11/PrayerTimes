//
//  Method.swift
//  PrayerTimes
//
//  Created by user on 02/10/2020.
//

import Foundation

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
