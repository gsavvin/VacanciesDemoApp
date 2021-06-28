//
//  VacanciesListPresenter.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation

class VacanciesListPresenter: VacanciesListModuleInput,
                              VacanciesListInteractorDelegate,
                              VacanciesListViewDelegate {
    
    private let interactor: VacanciesListInteractorInput
    private let router: VacanciesListRouterInput
    private weak var view: VacanciesListViewInput?
    weak var delegate: VacanciesListModuleDelegate?
    private let viewModelsBuilder = VacanciesListViewModelsBuilder()
    
    private var isLastPage = true

    init(interactor: VacanciesListInteractorInput,
         router: VacanciesListRouterInput,
         view: VacanciesListViewInput) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    // MARK: ModuleInput
    
    func setQuery(_ query: VacanciesQuery) {
        self.viewModelsBuilder.clearCachedViewModels()
        self.interactor.setQuery(query)
        self.interactor.loadVacancies()
    }

    // MARK: ViewDelegate
    
    func viewDidReadyForEvents() {
        let parameters: [VacanciesQuery.Parameter: Any] = [
            .text: "архитектор",
            .areaId: 1,
        ]
        
        let query = VacanciesQuery(parameters: parameters)
        self.setQuery(query)
    }
    
    func viewWillReachEndOfList() {
        if self.isLastPage == false {
            self.interactor.loadVacancies()
        }
    }

    // MARK: InteractorDelegate
    
    func didLoad(vacanciesResult: VacanciesResult) {
        let viewModels = self.viewModelsBuilder.viewModels(vacanciesResult: vacanciesResult)
        self.isLastPage = vacanciesResult.isLastPage
        self.view?.setViewModels(viewModels)
    }

    func didFailedLoadVacancies(error: Error?) {
        // Show error message with refresh button or reload after some time interval if not first page
    }
}
