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
    
    public func fetchPrayerTimes(url: URL, completion: @escaping ((Result<Any, CustomError>) -> Void)) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.init(title: "Error", message: "Add localizable error message")))
            }
            
            guard let data = data else {
                completion(.failure(.init(title: "Error", message: "Add localizable error message")))
                return
            }
            
            
            
            completion(.success("Success"))
            
        }
        .resume()
    }
}
