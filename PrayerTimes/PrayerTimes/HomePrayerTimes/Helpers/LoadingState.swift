//
//  LoadingState.swift
//  PrayerTimes
//
//  Created by user on 04/10/2020.
//

import Foundation

enum LoadingState: Equatable {
    case loading
    case loaded
    case failed
}

class StateManager: ObservableObject { //ADD TESTS FOR THIS
   
    @Published var prayerTimesState: LoadingState
    @Published var displayDateState: LoadingState
    
    var state: LoadingState {
        
        if prayerTimesState == .loaded && displayDateState == .loaded {
            return .loaded
        }
        
        if prayerTimesState == .failed || displayDateState == .failed {
            return .failed
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
    
    func failed() {
        prayerTimesState = .failed
        displayDateState = .failed
    }
    
    func loading() {
        prayerTimesState = .loading
        displayDateState = .loading
    }
}
