//
//  VacanciesListAssembly.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation

public class VacanciesListAssembly: NSObject {

    public static func make() -> VacanciesListViewController {
        let baseUrl = "https://api.hh.ru"
        let vacanciesService = VacanciesService(requestBuilder: VacanciesRequestBuilder(baseUrl: baseUrl),
                                                networkService: NetworkService.shared)
        let interactor = VacanciesListInteractor(vacanciesService: vacanciesService)
        
        let viewController = VacanciesListViewController()
        let router = VacanciesListRouter(viewController: viewController)
        let presenter = VacanciesListPresenter(interactor: interactor,
                                               router: router,
                                               view: viewController)
        viewController.delegate = presenter
        viewController.moduleInput = presenter
        interactor.delegate = presenter

        return viewController
    }
}
