//
//  Throwable.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
    
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        result = Result(catching: { try T(from: decoder) })
    }
}
