//
//  DateData+DecodableTests.swift
//  PrayerTimesTests
//
//  Created by user on 02/10/2020.
//

import XCTest
@testable import PrayerTimes

class DateData_DecodableTests: XCTestCase {


    func testDecodingDateInfoReturnsNotNil() throws {
        
        //Given
        let decoder = JSONDecoder()
        
        //When
        let data = try XCTUnwrap(dateData)
        let dateInfo = try XCTUnwrap(decoder.decode(DateInfo.self, from: data))
        
        //Then
        XCTAssertNotNil(dateInfo)
    }
    
    func testDecodesDataCorrectly() throws {
        
        //Given
        let decoder = JSONDecoder()
        
        //When
        let data = try XCTUnwrap(dateData)
        let dateInfo = try XCTUnwrap(decoder.decode(DateInfo.self, from: data))
        
        //Then
        XCTAssertEqual(dateInfo.timestamp, "1601510405")
    }
    
    let dateData = """
        {
          "readable": "01 Oct 2020",
          "timestamp": "1601510405",
          "hijri": {
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
          },
          "gregorian": {
            "date": "01-10-2020",
            "format": "DD-MM-YYYY",
            "day": "01",
            "weekday": {
              "en": "Thursday"
            },
            "month": {
              "number": 10,
              "en": "October"
            },
            "year": "2020",
            "designation": {
              "abbreviated": "AD",
              "expanded": "Anno Domini"
            }
          }
        }
    """.data(using: .utf8)
}
