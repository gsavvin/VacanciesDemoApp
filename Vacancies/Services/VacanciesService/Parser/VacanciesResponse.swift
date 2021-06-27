//
//  VacanciesResponse.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import Foundation

struct VacanciesResponse: Codable {
    
    var items: [Vacancy]?
    var page, pages: Int?
}
