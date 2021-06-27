//
//  ThrobberViewModel.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 25.06.2021.
//

import Foundation

class ThrobberViewModel: ViewModelConfigurableCellViewModel {
    
    static var identifier = "ThrobberViewModelIdentifier"
    
    override var cellType: ViewModelConfigurableCell.Type {
        get { return ThrobberCollectionViewCell.self }
    }
}
