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
    @Binding var date: Date

    func makeUIViewController(context: UIViewControllerRepresentableContext<LocationPicker>) -> GMSAutocompleteViewController {
        GMSPlacesClient.provideAPIKey(Constants.googlePlacesApiKey)

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
                //Update settings
                let newLocationInfo = LocationInfo(cityName: "\(place.name!), \( 123)",
                                                lat: place.coordinate.latitude,
                                                long: place.coordinate.longitude)
                SettingsConfiguration.shared.locationInfo = newLocationInfo
                
                //Trigger fetch data
                let date = self.parent.date
                self.parent.date = date
                
                //Dismiss
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
