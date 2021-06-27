//
//  ThrobberCollectionViewCell.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 25.06.2021.
//

import UIKit

class ThrobberCollectionViewCell: ViewModelConfigurableCell {
    
    private var containerView: UIView!
    private var throbberView: UIActivityIndicatorView!
    
    override var viewModel: BaseViewModel? {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 170)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let containerInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.containerView.frame = bounds.inset(by: containerInsets)
        self.throbberView.frame = self.containerView.bounds
    }
    
    private func reloadData() {
        self.throbberView.startAnimating()
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
        
        self.throbberView = UIActivityIndicatorView()
        self.throbberView.tintColor = .secondaryLabel
        self.contentView.addSubview(self.throbberView)
    }
}
