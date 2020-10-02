//
//  HijriDate+DecodableTests.swift
//  PrayerTimesTests
//
//  Created by user on 02/10/2020.
//

import XCTest
@testable import PrayerTimes

class HijriDate_DecodableTests: XCTestCase {

    //Not Nil Test
    
    func testDecodesDataCorrectly() throws {
        
        //Given
        let decoder = JSONDecoder()
        
        //When
        let data = try XCTUnwrap(hijridata)
        let hijriDate = try XCTUnwrap(decoder.decode(DateElements.self, from: data))
        
        //Then
        XCTAssertEqual(hijriDate.day, "13")
        XCTAssertEqual(hijriDate.month.name, "Ṣafar")
        XCTAssertEqual(hijriDate.year, "1442")
    }
    
    let hijridata = """
        {
        "date": "13-02-1442",
        "format": "DD-MM-YYYY",
        "day": "13",
        "weekday": {
            "en": "Al Khamees",
                "ar": "الخميس"
        },
        "month": {
            "number": 2,
            "en": "Ṣafar",
            "ar": "صَفَر"
        },
        "year": "1442",
        "designation": {
            "abbreviated": "AH",
            "expanded": "Anno Hegirae"
        },
        "holidays": []
        }
    """.data(using: .utf8)

}
