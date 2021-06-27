//
//  RequestBuilderInterface.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

protocol VacanciesRequestBuilderInterface {
    
    init(baseUrl: String)
    func vacanciesRequest(query: VacanciesQuery) -> URLRequest?
}
