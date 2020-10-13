//
//  Service.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import Foundation

class Service {
    
    let prayerTimesCacheKey = "prayerImesCache"

    static let shared = Service()
    private init() {}
    
    #warning("Add actual (localized?) error messages")
    
    let cache = NSCache<NSString, PrayerTimesResponse>()
    
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
                self.storePrayerTimesResponse(urlString: url.absoluteString, response: prayerTimesResponse)
                completion(.success(prayerTimesResponse))
            } catch {
                completion(.failure(.init(title: "Error", message: "Unable to decode response")))
            }
        }
        .resume()
    }
    
    private func storePrayerTimesResponse(urlString: String, response: PrayerTimesResponse) {
        //Save response to cach
        
    }
}
