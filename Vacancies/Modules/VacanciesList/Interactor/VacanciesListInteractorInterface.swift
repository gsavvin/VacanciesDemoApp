//
//  VacanciesListInteractorInterface.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation

protocol VacanciesListInteractorInput: AnyObject {
    
    func setQuery(_ query: VacanciesQuery)
    func loadVacancies()
}


protocol VacanciesListInteractorDelegate: AnyObject {
    
    func didLoad(vacanciesResult: VacanciesResult)
    func didFailedLoadVacancies(error: Error?)
}
