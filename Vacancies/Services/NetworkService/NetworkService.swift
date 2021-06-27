//
//  NetworkService.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import Foundation

class NetworkService: NetworkServiceInterface {
    
    static let shared = NetworkService()
    private let session = URLSession.shared
    
    private init() { }
    
    func execute(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
