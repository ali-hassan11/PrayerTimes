//
//  LoadingState.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import Foundation

enum Failure {
    case noInternet
    case locationDisabled
    case geoCodingError
}

enum LoadingState: Equatable {
    case loading
    case loaded
    case failed(Failure)
}

class StateManager: ObservableObject {
   
    @Published var displayDateState: LoadingState
    @Published var prayerTimesState: LoadingState

    var state: LoadingState {
        
        if prayerTimesState == .loaded && displayDateState == .loaded {
            return .loaded
        }
        
        if prayerTimesState == .failed(.noInternet) || displayDateState == .failed(.noInternet) {
            return .failed(.noInternet)
        }
        
        if prayerTimesState == .failed(.locationDisabled) || displayDateState == .failed(.locationDisabled) {
            return .failed(.locationDisabled)
        }
        
        if prayerTimesState == .failed(.geoCodingError) || displayDateState == .failed(.geoCodingError) {
            return .failed(.geoCodingError)
        }
        
        return .loading
    }
    
    init(prayerTimesState: LoadingState = .loading, displayDateState: LoadingState = .loading) {
        self.prayerTimesState = prayerTimesState
        self.displayDateState = displayDateState
    }
    
    func prayerTimesLoaded() {
        prayerTimesState = .loaded
    }

    func datesLoaded() {
        displayDateState = .loaded
    }
    
    func failed(with failure: Failure) {
        prayerTimesState = .failed(failure)
        displayDateState = .failed(failure)
    }
    
    func loading() {
        prayerTimesState = .loading
        displayDateState = .loading
    }
}
