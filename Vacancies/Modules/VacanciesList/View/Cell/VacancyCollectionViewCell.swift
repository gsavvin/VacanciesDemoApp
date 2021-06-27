//
//  VacancyCollectionViewCell.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import UIKit

class VacancyCollectionViewCell: ViewModelConfigurableCell {
    
    private var containerView: UIView!
    private var contentContainerView: UIView!
    private var nameLabel: UILabel!
    private var salaryLabel: UILabel!
    private var areaLabel: UILabel!
    private var employerLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    private var vacancyViewModel: VacancyViewModel? {
        didSet {
            self.reloadData()
        }
    }
    
    override var viewModel: BaseViewModel? {
        get { return self.vacancyViewModel }
        set {
            if let vacancyViewModel = newValue as? VacancyViewModel {
                self.vacancyViewModel = vacancyViewModel
            }
        }
    }
    
    struct LayoutMeasure {

        var containerFrame: CGRect
        var contentContainerFrame: CGRect
        
        var nameFrame: CGRect
        var salaryFrame: CGRect
        var areaFrame: CGRect
        var employerFrame: CGRect
        var descriptionFrame: CGRect
        
        var cellHeight: CGFloat
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let height = self.layoutMeasure(forSize: size).cellHeight
        return CGSize(width: size.width, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let measure = self.layoutMeasure(forSize: self.bounds.size)
        
        self.containerView.frame = measure.containerFrame
        self.contentContainerView.frame = measure.contentContainerFrame
        
        self.nameLabel.frame = measure.nameFrame
        self.salaryLabel.frame = measure.salaryFrame
        self.areaLabel.frame = measure.areaFrame
        self.employerLabel.frame = measure.employerFrame
        self.descriptionLabel.frame = measure.descriptionFrame
    }
    
    private func reloadData() {
        self.nameLabel.text = self.vacancyViewModel?.name
        self.salaryLabel.text = self.vacancyViewModel?.salary
        self.areaLabel.text = self.vacancyViewModel?.area
        self.employerLabel.text = self.vacancyViewModel?.employer
        self.descriptionLabel.text = self.vacancyViewModel?.descriptionText
        
        self.setNeedsLayout()
    }
    
    private func setupSubviews() {
        self.containerView = UIView()
        self.containerView.backgroundColor = .tertiarySystemBackground
        self.containerView.layer.cornerRadius = 16
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.15
        self.containerView.layer.shadowOffset = .zero
        self.containerView.layer.shadowRadius = 10
        self.contentView.addSubview(self.containerView)
        
        self.contentContainerView = UIView()
        self.containerView.addSubview(self.contentContainerView)
        
        self.nameLabel = UILabel()
        self.nameLabel.numberOfLines = 0
        self.nameLabel.textColor = .label
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.contentContainerView.addSubview(self.nameLabel)
        
        self.salaryLabel = UILabel()
        self.salaryLabel.numberOfLines = 1
        self.salaryLabel.textColor = .label
        self.salaryLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentContainerView.addSubview(self.salaryLabel)
        
        self.areaLabel = UILabel()
        self.areaLabel.numberOfLines = 1
        self.areaLabel.textColor = .label
        self.areaLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentContainerView.addSubview(self.areaLabel)
        
        self.employerLabel = UILabel()
        self.employerLabel.numberOfLines = 0
        self.employerLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.employerLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.contentContainerView.addSubview(self.employerLabel)
        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textColor = .label
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentContainerView.addSubview(self.descriptionLabel)
    }
    
    private func layoutMeasure(forSize size: CGSize) -> VacancyCollectionViewCell.LayoutMeasure {
        let bounds = CGRect(origin: CGPoint(), size: size)
        
        let containerInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let containerFrame = bounds.inset(by: containerInsets)
        let containerBounds = CGRect(origin: CGPoint(),
                                     size: containerFrame.size)
        let contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let contentContainerFrame = containerBounds.inset(by: contentInsets)
        
        let maxContentSize = contentContainerFrame.size
        
        let nameSize = self.nameLabel.sizeThatFits(maxContentSize)
        let nameFrame = CGRect(origin: CGPoint(), size: nameSize)
        
        let salarySize = self.salaryLabel.sizeThatFits(maxContentSize)
        let salaryFrame = CGRect(x: 0,
                                 y: nameFrame.maxY + 6,
                                 width: salarySize.width,
                                 height: salarySize.height)
        
        let areaSize = self.areaLabel.sizeThatFits(maxContentSize)
        let areaFrame = CGRect(x: 0,
                               y: salaryFrame.maxY + 14,
                               width: areaSize.width,
                               height: areaSize.height)
        
        let employerSize = self.employerLabel.sizeThatFits(maxContentSize)
        let employerFrame = CGRect(x: 0,
                                   y: areaFrame.maxY + 5,
                                   width: employerSize.width,
                                   height: employerSize.height)
        
        let descriptionSize = self.descriptionLabel.sizeThatFits(maxContentSize)
        let descriptionY: CGFloat = employerFrame.maxY + (descriptionSize.height > 0 ? 14 : 0)
        let descriptionFrame = CGRect(x: 0,
                                      y: descriptionY,
                                      width: descriptionSize.width,
                                      height: descriptionSize.height)
        
        let cellHeight = descriptionFrame.maxY
                         + containerInsets.top
                         + contentInsets.top
                         + containerInsets.bottom
                         + contentInsets.bottom
        
        return VacancyCollectionViewCell.LayoutMeasure(containerFrame: containerFrame,
                                                      contentContainerFrame: contentContainerFrame,
                                                      nameFrame: nameFrame,
                                                      salaryFrame: salaryFrame,
                                                      areaFrame: areaFrame,
                                                      employerFrame: employerFrame,
                                                      descriptionFrame: descriptionFrame,
                                                      cellHeight: cellHeight)
    }
}


