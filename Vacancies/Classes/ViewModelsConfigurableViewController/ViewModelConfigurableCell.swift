//
//  BaseCollectionViewCell.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import UIKit

class ViewModelConfigurableCell: UICollectionViewCell, ViewModelConfigurable {
    
    var viewModel: BaseViewModel?
    
    static var reuseId: String {
        get { return String(describing: self) + "ReuseId" }
    }
}


