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
    
    private let loadingQueue = DispatchQueue(label: "com.gsavvin.vacancies.queue",
                                             qos: .userInteractive,
                                             attributes: .concurrent)
    
    init(vacanciesService: VacanciesServiceInterface) {
        self.vacanciesService = vacanciesService
    }
    
    // MARK: InteractorInput
    
    func setQuery(_ query: VacanciesQuery) {
        self.query = query
        self.query?.pagination = Pagination.defaultPagination
    }
    
    func loadVacancies() {
        if let query = self.query {
            self.loadVacancies(query: query)
        }
    }
    
    // MARK: Private
    
    private func loadVacancies(query: VacanciesQuery) {
        if self.isLoading {
            return
        }
        
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
