//
//  VacanciesParser.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

class VacanciesParser {
    
    func parse(vacanciesResponse response: Data) -> VacanciesResult {
        var vacancies: [Vacancy]?
        var isLastPage = true
        
        if let vacanciesResponse = try? JSONDecoder().decode(VacanciesResponse.self, from: response) {
            vacancies = vacanciesResponse.items
            if let page = vacanciesResponse.page, let pages = vacanciesResponse.pages {
                isLastPage = page >= pages - 1
            }
        }

        return VacanciesResult(vacancies: vacancies,
                               isLastPage: isLastPage)
    }
}
