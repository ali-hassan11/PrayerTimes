//
//  Service.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

class Service {
    
    struct CustomError: Error {
        let title: String
        let message: String
    }
    
    static let shared = Service()
    private init() {}
    
    public func fetchPrayerTimes(url: URL, completion: @escaping ((Result<PrayerTimesResponse, CustomError>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.init(title: "Error", message: "Add localizable error message")))
            }
            
            guard let data = data else {
                completion(.failure(.init(title: "Error", message: "Add localizable error message")))
                return
            }
            
            do {
                let prayerTimesResponse = try JSONDecoder().decode(PrayerTimesResponse.self, from: data)
                completion(.success(prayerTimesResponse))
            } catch {
                completion(.failure(.init(title: "Error", message: "Add localized message")))
            }
        }
        .resume()
    }
}
