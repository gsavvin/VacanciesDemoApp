//
// VacanciesListInteractor.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation

class VacanciesListInteractor: VacanciesListInteractorInput {

    weak var delegate: VacanciesListInteractorDelegate?
    let vacanciesService: VacanciesServiceInterface
    
    private var query: VacanciesQuery?
    private var isLoading: Bool = false
    
    private let loadingQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(vacanciesService: VacanciesServiceInterface) {
        self.vacanciesService = vacanciesService
    }
    
    // MARK: InteractorInput
    
    func loadVacancies(query: VacanciesQuery?) {
        var runningQuery = query ?? self.query ?? VacanciesQuery()
        
        if (runningQuery == self.query) == false {
            runningQuery.pagination = Pagination.defaultPagination
            self.query = runningQuery
        } else if self.isLoading {
            return
        }

        self.loadVacancies(query: runningQuery)
    }
    
    private func loadVacancies(query: VacanciesQuery) {
        self.isLoading = true
        
        self.loadingQueue.async {
            self.vacanciesService.loadVacancies(query: query) { [weak self] (vacansiesResult, error) in
                guard let self = self else {return}
                guard query == self.query else { return }
                
                self.isLoading = false
                
                if vacansiesResult != nil {
                    if vacansiesResult?.isLastPage == false {
                        self.query?.pagination?.incrementPage()
                    }
                    
                    self.delegate?.didLoad(vacanciesResult: vacansiesResult!)
                } else {
                    self.delegate?.didFailedLoadVacancies(error: error)
                }
            }
        }
    }
}
