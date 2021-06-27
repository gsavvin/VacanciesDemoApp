//
//  VacanciesService.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

class VacanciesService: NSObject, VacanciesServiceInterface {
    
    let requestBuilder: VacanciesRequestBuilderInterface
    let networkService: NetworkServiceInterface
    let vacanciesParser: VacanciesParser
    
    init(requestBuilder: VacanciesRequestBuilderInterface,
         networkService: NetworkServiceInterface) {
        self.requestBuilder = requestBuilder
        self.networkService = networkService
        self.vacanciesParser = VacanciesParser()
    }
    
    func loadVacancies(query: VacanciesQuery, completion: @escaping (VacanciesResult?, Error?) -> ()) {
        if let request = self.requestBuilder.vacanciesRequest(query: query) {
            self.networkService.execute(request: request) { [weak self] (response, _, error) in
                guard let self = self else {return}
                
                if let response = response {
                    let result = self.vacanciesParser.parse(vacanciesResponse: response)
                    completion(result, nil)
                } else {
                    completion(nil, error)
                }
            }
        } else {
            completion(nil, nil)
        }
    }
}




