//
//  VacanciesServiceInterface.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

typealias isLastPage = Bool

protocol VacanciesServiceInterface {

    func loadVacancies(query: VacanciesQuery, completion: @escaping (VacanciesResult?, Error?) -> ())
}
