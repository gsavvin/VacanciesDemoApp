//
//  VacanciesListModuleInterface.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation

protocol VacanciesListModuleInput: AnyObject {
    
    var delegate: VacanciesListModuleDelegate? {get set}
}

protocol VacanciesListModuleDelegate: AnyObject {
    
}
