//
//  PrayerTimesTests.swift
//  PrayerTimesTests
//
//  Created by user on 01/10/2020.
//

import XCTest
@testable import PrayerTimes

class URLBuilderTests: XCTestCase {
        
    func testURLBuilderReturnsNotNil() {
        
        //Given
        let prayerTimeConfiguration = PrayerTimesConfiguration(timestamp: "00000000",
                                                       coordinates: .init(latitude: "111", longitude: "222"),
                                                       method: .islamicSocietyOfNorthAmerica,
                                                       school: .hanafi,
                                                       timeZone: .current)
        
        //When
        let url = URLBuilder.prayerTimesForDateURL(configuration: prayerTimeConfiguration)
        
        //Then
        XCTAssertNotNil(url)
    }
    
    func testURLBuilderCreatesCorrectUrl() throws {
        
        //Given
        let prayerTimeConfiguration1 = PrayerTimesConfiguration(timestamp: "00000000",
                                                       coordinates: .init(latitude: "111", longitude: "222"),
                                                       method: .islamicSocietyOfNorthAmerica,
                                                       school: .hanafi,
                                                       timeZone: .current)
        let prayerTimeConfiguration2 = PrayerTimesConfiguration(timestamp: "11111111",
                                                       coordinates: .init(latitude: "333", longitude: "444"),
                                                       method: .muslimWorldLeague,
                                                       school: .shafi,
                                                       timeZone: .current)
        let prayerTimeConfiguration3 = PrayerTimesConfiguration(timestamp: "22222222",
                                                               coordinates: .init(latitude: "555", longitude: "666"),
                                                       method: .siyanetIsleriBaskanligiTurkey,
                                                       school: .hanafi,
                                                       timeZone: .current)
        let prayerTimeConfiguration4 = PrayerTimesConfiguration(timestamp: "33333333",
                                                       coordinates: .init(latitude: "777", longitude: "888"),
                                                       method: .gulfRegion,
                                                       school: .shafi,
                                                       timeZone: .current)
        let prayerTimeConfiguration5 = PrayerTimesConfiguration(timestamp: "44444444",
                                                       coordinates: .init(latitude: "999", longitude: "000"),
                                                       method: .majlisUgamaIslamSingapuraSingapore,
                                                       school: .hanafi,
                                                       timeZone: .current)

        //When
        let url1 = URLBuilder.prayerTimesForDateURL(configuration: prayerTimeConfiguration1)
        let url2 = URLBuilder.prayerTimesForDateURL(configuration: prayerTimeConfiguration2)
        let url3 = URLBuilder.prayerTimesForDateURL(configuration: prayerTimeConfiguration3)
        let url4 = URLBuilder.prayerTimesForDateURL(configuration: prayerTimeConfiguration4)
        let url5 = URLBuilder.prayerTimesForDateURL(configuration: prayerTimeConfiguration5)


        //Then
        let expectedUrl1 = "https://api.aladhan.com/v1/timings/00000000?latitude=111&longitude=222&method=2&school=1&timezonestring=Europe/London"
        let expectedUrl2 = "https://api.aladhan.com/v1/timings/11111111?latitude=333&longitude=444&method=3&school=0&timezonestring=Europe/London"
        let expectedUrl3 = "https://api.aladhan.com/v1/timings/22222222?latitude=555&longitude=666&method=13&school=1&timezonestring=Europe/London"
        let expectedUrl4 = "https://api.aladhan.com/v1/timings/33333333?latitude=777&longitude=888&method=8&school=0&timezonestring=Europe/London"
        let expectedUrl5 = "https://api.aladhan.com/v1/timings/44444444?latitude=999&longitude=000&method=11&school=1&timezonestring=Europe/London"

        let urlString1 = try XCTUnwrap(url1?.absoluteString)
        let urlString2 = try XCTUnwrap(url2?.absoluteString)
        let urlString3 = try XCTUnwrap(url3?.absoluteString)
        let urlString4 = try XCTUnwrap(url4?.absoluteString)
        let urlString5 = try XCTUnwrap(url5?.absoluteString)

        XCTAssertEqual(urlString1, expectedUrl1)
        XCTAssertEqual(urlString2, expectedUrl2)
        XCTAssertEqual(urlString3, expectedUrl3)
        XCTAssertEqual(urlString4, expectedUrl4)
        XCTAssertEqual(urlString5, expectedUrl5)
    }
}
