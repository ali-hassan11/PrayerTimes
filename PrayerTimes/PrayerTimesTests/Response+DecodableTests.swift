//
//  Response+DecodableTests.swift
//  PrayerTimesTests
//
//  Created by user on 01/10/2020.
//

import XCTest
@testable import PrayerTimes

class Response_DecodableTests: XCTestCase {

    //Not Nil Test
    
    func testDecodesDataCorretly() throws {
        
        //Given
        let decoder = JSONDecoder()
        
        //When
        let data = try XCTUnwrap(responseData)
        let response = try XCTUnwrap(decoder.decode(PrayerTimesResponse.self, from: data))
        
        //Then
        let prayerTimesData = response.prayerTimesData
        XCTAssertEqual(response.status, "OK")
        XCTAssertEqual(prayerTimesData.timings.count, 9)
        XCTAssertEqual(prayerTimesData.timings["Fajr"], "05:30")
        XCTAssertEqual(prayerTimesData.timings["Sunrise"], "07:02")
        XCTAssertEqual(prayerTimesData.timings["Dhuhr"], "12:50")
        XCTAssertEqual(prayerTimesData.timings["Asr"], "15:56")
        XCTAssertEqual(prayerTimesData.timings["Maghrib"], "18:37")
        XCTAssertEqual(prayerTimesData.timings["Isha"], "20:09")
        
        XCTAssertEqual(prayerTimesData.dateInfo.hijriDate.day, "13")
        XCTAssertEqual(prayerTimesData.dateInfo.hijriDate.month.name, "Ṣafar")
        XCTAssertEqual(prayerTimesData.dateInfo.hijriDate.year, "1442")

        XCTAssertEqual(prayerTimesData.dateInfo.gergorianDate.day, "01")
        XCTAssertEqual(prayerTimesData.dateInfo.gergorianDate.month.name, "October")
        XCTAssertEqual(prayerTimesData.dateInfo.gergorianDate.year, "2020")
    }

    let responseData = """
    {
      "code": 200,
      "status": "OK",
      "data": {
        "timings": {
          "Fajr": "05:30",
          "Sunrise": "07:02",
          "Dhuhr": "12:50",
          "Asr": "15:56",
          "Sunset": "18:37",
          "Maghrib": "18:37",
          "Isha": "20:09",
          "Imsak": "05:20",
          "Midnight": "00:50"
        },
        "date": {
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
        },
        "meta": {
          "latitude": 51.508515,
          "longitude": -0.1254872,
          "timezone": "Europe/London",
          "method": {
            "id": 2,
            "name": "Islamic Society of North America (ISNA)",
            "params": {
              "Fajr": 15,
              "Isha": 15
            }
          },
          "latitudeAdjustmentMethod": "ANGLE_BASED",
          "midnightMode": "STANDARD",
          "school": "STANDARD",
          "offset": {
            "Imsak": 0,
            "Fajr": 0,
            "Sunrise": 0,
            "Dhuhr": 0,
            "Asr": 0,
            "Maghrib": 0,
            "Sunset": 0,
            "Isha": 0,
            "Midnight": 0
          }
        }
      }
    }
    """.data(using: .utf8)

}

