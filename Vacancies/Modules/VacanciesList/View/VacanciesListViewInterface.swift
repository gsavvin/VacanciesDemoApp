//
//  VacanciesListViewInterface.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation

protocol VacanciesListViewInput: AnyObject {
    
    func setViewModels(_ viewModels: [ViewModelConfigurableCellViewModel])
}


protocol VacanciesListViewDelegate: AnyObject {
    
    func viewDidReadyForEvents()
    func viewWillReachEndOfList()
}
