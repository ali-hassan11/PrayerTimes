//
//  PlacePicker.swift
//  PrayerTimes
//
//  Created by user on 11/10/2020.
//

import Foundation
import UIKit
import SwiftUI
import GooglePlaces

struct LocationPicker: UIViewControllerRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var date: Date //(Here <- SettingsView <- viewModel property in TabsView)

    func makeUIViewController(context: UIViewControllerRepresentableContext<LocationPicker>) -> GMSAutocompleteViewController {
        
        GMSPlacesClient.provideAPIKey("AIzaSyAgIjIKhiEllBtS2f_OSGTxZyHSJI-lXpg")

//        GMSPlacesClient.provideAPIKey(Constants.googlePlacesApiKey)

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator

        autocompleteController.tintColor = .systemPink
        autocompleteController.primaryTextColor = .label
        autocompleteController.secondaryTextColor = .secondaryLabel
        autocompleteController.tableCellSeparatorColor = .separator
        autocompleteController.tableCellBackgroundColor = .systemBackground

        let filter = GMSAutocompleteFilter()
        filter.type = .region
        autocompleteController.autocompleteFilter = filter

        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<LocationPicker>) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {

        var parent: LocationPicker

        init(_ parent: LocationPicker) {
            self.parent = parent
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                print(place.description.description as Any)
                
                for place in place.addressComponents! {
                    print(place)
                }
                
                let location = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                GeocoderWrapper().locationInfo(for: location) { [weak self] result in
                    
                    switch result {
                    case .success((let locationInfo, let timeZone)):
                        self?.handleSuccess(with: locationInfo, and: timeZone)
                        
                    case .failure(let error):
                        print(error.message) //TO-DO: Handle error
                    }
                }
            }
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        private func handleSuccess(with locationInfo: LocationInfo, and timeZone: TimeZone) {
            SettingsConfiguration.shared.locationInfo = locationInfo
            SettingsConfiguration.shared.timeZone = timeZone

            //Trigger fetch data
            let date = self.parent.date
            self.parent.date = date
            
            //Dismiss
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
