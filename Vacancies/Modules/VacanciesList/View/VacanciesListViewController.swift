//
//  VacanciesListViewController.swift
//  Created by Геннадий Саввин on 23/06/2021.
//

import Foundation
import UIKit

public class VacanciesListViewController: ViewModelsConfigurableViewController,
                                          VacanciesListViewInput {
    
    weak var delegate: VacanciesListViewDelegate?
    var moduleInput: VacanciesListModuleInput!
    
    private var registeredCellIdetifiers = Set<String>()
    private var cachedCalculationCells = [String: Any]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Вакансии"

        self.delegate?.viewDidReadyForEvents()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let collectionViewInsets = UIEdgeInsets(top: 0,
                                                left: self.view.safeAreaInsets.left,
                                                bottom: self.view.safeAreaInsets.bottom,
                                                right: self.view.safeAreaInsets.right)
        self.collectionView.frame = self.view.bounds.inset(by: collectionViewInsets)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let viewModelsCount = (self.viewModels?.count ?? 0)
        if indexPath.row == viewModelsCount - 4 {
            self.delegate?.viewWillReachEndOfList()
        }
    }
}

