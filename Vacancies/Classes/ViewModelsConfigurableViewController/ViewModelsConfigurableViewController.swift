//
//  ViewModelsConfigurableViewController.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import UIKit

public class ViewModelsConfigurableViewController: UIViewController,
                                                   UICollectionViewDelegate,
                                                   UICollectionViewDataSource,
                                                   UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    
    private(set) var viewModels: [ViewModelConfigurableCellViewModel]? {
        didSet {
            if let viewModels = self.viewModels {
                self.registerCells(fromViewModels: oldValue != nil ?
                                                   Set(viewModels).subtracting(Set(oldValue!)) :
                                                   Set(viewModels))
            }
        }
    }
    
    private var registeredCellIdentifiers = Set<String>()
    private var cachedCellCalculatedHeights = [String: Any]()
    private var cachedCalculationCells = [String: Any]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupCollectionView()
    }

    func setViewModels(_ viewModels: [ViewModelConfigurableCellViewModel]) {
        self.viewModels = viewModels

        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    public override func viewWillTransition(to size: CGSize,
                                            with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.cachedCellCalculatedHeights = [:]
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt
                                indexPath: IndexPath) -> UICollectionViewCell {
        var cell: ViewModelConfigurableCell?
        if let viewModel = self.viewModels?[indexPath.row] {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellType.reuseId,
                                                      for: indexPath) as? ViewModelConfigurableCell
            cell?.viewModel = viewModel
        }

        return cell ?? ViewModelConfigurableCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModels?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 1
        let collectionViewSize = self.collectionView.bounds.size
        if let viewModel = self.viewModels?[indexPath.row] {
            
            if let id = viewModel.identifier, !id.isEmpty, let cachedHeight = self.cachedCellCalculatedHeights[id] as? CGFloat {
                height = cachedHeight
            } else {
                var cell: ViewModelConfigurableCell?
                let reuseId = viewModel.cellType.reuseId
                if let cachedCell = self.cachedCalculationCells[reuseId] {
                    cell = cachedCell as? ViewModelConfigurableCell
                } else {
                    cell = viewModel.cellType.init()
                    self.cachedCalculationCells[reuseId] = cell
                }

                cell?.viewModel = viewModel
                height = cell?.sizeThatFits(collectionViewSize).height ?? height
                
                if let id = viewModel.identifier, !id.isEmpty {
                    self.cachedCellCalculatedHeights[id] = height
                }
            }
        }

        return CGSize(width: collectionViewSize.width, height: height)
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: CGRect(),
                                               collectionViewLayout: flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.backgroundColor = .clear
        
        self.view.addSubview(self.collectionView)
    }
    
    private func registerCells(fromViewModels viewModels: Set<ViewModelConfigurableCellViewModel>) {
        var cellsToRegister = [ViewModelConfigurableCell.Type]()
        viewModels.forEach({ (viewModel) in
            if !self.registeredCellIdentifiers.contains(viewModel.cellType.reuseId) {
                cellsToRegister.append(viewModel.cellType)
                self.registeredCellIdentifiers.insert(viewModel.cellType.reuseId)
            }
        })
        
        if !cellsToRegister.isEmpty {
            DispatchQueue.main.async {
                cellsToRegister.forEach { (cell) in
                    self.collectionView.register(cell,
                                                 forCellWithReuseIdentifier: cell.reuseId)
                }
            }
        }
    }
}
