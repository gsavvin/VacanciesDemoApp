//
//  NetworkServiceInterface.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import Foundation

protocol NetworkServiceInterface {
    
    func execute(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> ())
}
