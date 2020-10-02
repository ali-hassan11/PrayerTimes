//
//  PrayerTimesHomeViewModelTests.swift
//  PrayerTimesTests
//
//  Created by user on 02/10/2020.
//

import XCTest
@testable import PrayerTimes

class PrayerTimesHomeViewModelTests: XCTestCase {
    
    func testPrayersAttributesAreCorrect() {
        
        let expectation = self.expectation(description: "Waiting for handlePrayerTimes to be called")
        
        //Given a response
        let response = stubResponse
        
        //When a viewModel is instantiated and handlePrayerTimes is invoked
        let viewModel = PrayerTimesHomeViewModel(settings: stubSettingsCongiguration)
        
        viewModel.handlePrayerTimes(prayerTimesResponse: response) { prayers in
            viewModel.prayers = prayers
            expectation.fulfill()
        }
        
        //Then prayers attributes are correct
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.prayers.count, 6)
        XCTAssertEqual(viewModel.prayers.first?.name, expectedPrayers.first?.name)
        XCTAssertEqual(viewModel.prayers.first?.formattedTime, expectedPrayers.first?.formattedTime)
        
        XCTAssertEqual(viewModel.prayers.last?.name, expectedPrayers.last?.name)
        XCTAssertEqual(viewModel.prayers.last?.formattedTime, expectedPrayers.last?.formattedTime)
    }
    
    func testFormattedDateIsCorrect() {

        let expectation = self.expectation(description: "Waiting for handleData to be called")
        
        //Given a response
        let response = stubResponse

        //When handlePrayerTimes and handleDate are invkokd
        let viewModel = PrayerTimesHomeViewModel(settings: stubSettingsCongiguration)
        
        viewModel.handleDate(prayerTimesResponse: response, dateType: .gregorian) { formattedDate in
            viewModel.formattedDate = formattedDate
            expectation.fulfill()
        }
        
        //Then formattedDate is correct
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel.formattedDate, "02 October, 2020")
    }
    
    
    //MARK: Test Data
    let stubSettingsCongiguration = SettingsConfiguration(dateType: .gregorian, method: .muslimWorldLeague, school: .hanafi, timeZone: .current)

    var stubResponse: PrayerTimesResponse {
        let timings = ["Fajr": "05:00", "Sunrise": "07:00", "Dhuhr": "12:00", "Asr": "16:00", "Maghrib": "18:00", "Isha": "20:00"]
        let hijriMonth = Month(name: "Ramandan")
        let hijriDate = DateElements(day: "1", month: hijriMonth, year: "1442", date: "01-09-1442", format: DateFormatter().apiDateFormat())
        let gregorianMonth = Month(name: "October")
        let gregorian = DateElements(day: "02", month: gregorianMonth, year: "2020", date: "02-10-2020", format: DateFormatter().apiDateFormat())
        let dateInfo = DateInfo(timestamp: "1601618400", hijriDate: hijriDate, gergorianDate: gregorian)
        let prayerTimesData = PrayerTimesData(timings: timings, dateInfo: dateInfo)
        
        return PrayerTimesResponse(status: "OK", prayerTimesData: prayerTimesData)
    }
    
    var expectedPrayers = [
        Prayer(name: "Fajr", timestamp: Date(), formattedTime: "05:00"),
        Prayer(name: "Sunrise", timestamp: Date(), formattedTime: "07:00"),
        Prayer(name: "Dhuhr", timestamp: Date(), formattedTime: "12:00"),
        Prayer(name: "Asr", timestamp: Date(), formattedTime: "16:00"),
        Prayer(name: "Maghrib", timestamp: Date(), formattedTime: "18:00"),
        Prayer(name: "Isha", timestamp: Date(), formattedTime: "20:00")
    ]
}
