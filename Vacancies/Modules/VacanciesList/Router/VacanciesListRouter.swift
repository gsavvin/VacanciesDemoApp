//
//  VacanciesListRouter.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import UIKit

class VacanciesListRouter: VacanciesListRouterInput {
    
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
    	self.viewController = viewController
    }
}
