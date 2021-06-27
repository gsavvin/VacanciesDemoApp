//
//  ViewModelConfigurableCellViewModel.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import UIKit

class ViewModelConfigurableCellViewModel: BaseViewModel {

    var cellType: ViewModelConfigurableCell.Type {
        get { return ViewModelConfigurableCell.self }
    }
}
