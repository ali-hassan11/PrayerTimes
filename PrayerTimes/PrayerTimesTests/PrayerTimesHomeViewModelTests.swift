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
        XCTAssertEqual(viewModel.prayers.count, 6)
        XCTAssertEqual(viewModel.prayers.first?.name, expectedPrayers.first?.name)
        XCTAssertEqual(viewModel.prayers.first?.formattedTime, expectedPrayers.first?.formattedTime)
        
        XCTAssertEqual(viewModel.prayers.count, 6)
        XCTAssertEqual(viewModel.prayers.last?.name, expectedPrayers.last?.name)
        XCTAssertEqual(viewModel.prayers.last?.formattedTime, expectedPrayers.last?.formattedTime)

        wait(for: [expectation], timeout: 1)
    }
    
    
    func testNextPrayerAreCorrect() {
        
        //Given a response
        
        //When handlePrayerTimes is invkokd
        
        //Then nextPrayer is correct
    }
    
    
    func testFormattedDateIsCorrect() {
        
        //Given a response
        
        //When handleDate is invkokd
        
        //Then formattedDate is correct
    }
    
    //func TestFetchDataIsInvoked() {
    
    let stubSettingsCongiguration = SettingsConfiguration(dateType: .gregorian, method: .muslimWorldLeague, school: .hanafi, timeZone: .current)

    var stubResponse: PrayerTimesResponse {
        let timings = ["Fajr": "00:00", "Sunrise": "11:11", "Dhuhr": "22:22", "Asr": "33:33", "Maghrib": "44:44", "Isha": "55:55"]
        let hijriMonth = Month(name: "Ramandan")
        let hijriDate = DateElements(day: "1", month: hijriMonth, year: "1442", date: "01-09-1442", format: DateFormatter().apiDateFormat())
        let gregorianMonth = Month(name: "March")
        let gregorian = DateElements(day: "1", month: gregorianMonth, year: "2020", date: "01-03-2020", format: DateFormatter().apiDateFormat())
        let dateInfo = DateInfo(timestamp: "99999999", hijriDate: hijriDate, gergorianDate: gregorian)
        let prayerTimesData = PrayerTimesData(timings: timings, dateInfo: dateInfo)
        
        return PrayerTimesResponse(status: "OK", prayerTimesData: prayerTimesData)
    }
    
    var expectedPrayers = [
        Prayer(name: "Fajr", timestamp: Date(), formattedTime: "00:00"),
        Prayer(name: "Sunrise", timestamp: Date(), formattedTime: "11:11"),
        Prayer(name: "Dhuhr", timestamp: Date(), formattedTime: "22:22"),
        Prayer(name: "Asr", timestamp: Date(), formattedTime: "33:33"),
        Prayer(name: "Maghrib", timestamp: Date(), formattedTime: "44:44"),
        Prayer(name: "Isha", timestamp: Date(), formattedTime: "55:55")
    ]
}

//class MockViewModel: PrayerTimesHomeViewModelProtocol {
//    
//    
//    func fetchData(settings: SettingsConfiguration) {
//        
//    }
//    
//    func handlePrayerTimes(prayerTimesResponse: PrayerTimesResponse) {
//        
//    }
//    
//    func handleDate(prayerTimesResponse: PrayerTimesResponse, dateType: DateMode) {
//        
//    }
//}
