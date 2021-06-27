//
//  VacancyViewModel.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

class VacancyViewModel: ViewModelConfigurableCellViewModel {
    
    override var cellType: ViewModelConfigurableCell.Type {
        get { return VacancyCollectionViewCell.self }
    }

    var id: String
    var name: String
    var employer: String?
    var area: String?
    var salary: String?
    var descriptionText: String?
    
    init(id: String,
         name: String,
         employer: String?,
         area: String?,
         salary: String?,
         description: String?) {
        self.id = id
        self.name = name
        self.employer = employer
        self.area = area
        self.salary = salary
        self.descriptionText = description
    }
}
