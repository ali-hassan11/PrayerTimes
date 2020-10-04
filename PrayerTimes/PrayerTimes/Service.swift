//
//  Service.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

class Service {
    
    static let shared = Service()
    private init() {}
    
    #warning("Add actual (localized?) error messages")
    
    public func fetchPrayerTimes(url: URL, completion: @escaping ((Result<PrayerTimesResponse, CustomError>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.init(title: "Error", message: "Unable to fetch data")))
            }
            
            guard let data = data else {
                completion(.failure(.init(title: "Error", message: "No date found from request")))
                return
            }
            
            do {
                let prayerTimesResponse = try JSONDecoder().decode(PrayerTimesResponse.self, from: data)
                completion(.success(prayerTimesResponse))
            } catch {
                completion(.failure(.init(title: "Error", message: "Unable to decode response")))
            }
        }
        .resume()
    }
}
