//
//  UILoadingModalViewController.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 05/06/24.
//

import Foundation
import UIKit

class UILoadingModalViewController: UIViewController {
    struct DialogInfo {
        var title: String
        var description: String?
        var color: UIColor?
        
        init(title: String, description: String? = nil, color: UIColor? = nil) {
            self.title = title
            self.description = description
            self.color = color
        }
    }
    
    // MARK: - Outlets
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loadingModalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .red
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13, *){
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var titleDialogLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionDialogLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dialogInfo : DialogInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        self.addSubViews()
        self.setupConstraint()
        setupRadius()
        setupLocalizedTexts()
    }
    
    private func setupRadius(){
        self.loadingModalView.layer.cornerRadius = 8
        self.contentView.addShadow()
    }
    
    func addSubViews(){
        view.addSubview(self.contentView)
        contentView.addSubview(loadingModalView)
        loadingModalView.addSubview(activityIndicator)
        loadingModalView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleDialogLabel)
        verticalStack.addArrangedSubview(descriptionDialogLabel)
    }
    
    func setupConstraint(){
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        loadingModalView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36).isActive = true
        loadingModalView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36).isActive = true
        loadingModalView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingModalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        activityIndicator.leftAnchor.constraint(equalTo: loadingModalView.leftAnchor, constant: 12).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: loadingModalView.topAnchor,constant: 20).isActive = true
        
        verticalStack.leftAnchor.constraint(equalTo: activityIndicator.rightAnchor, constant: 12).isActive = true
        verticalStack.topAnchor.constraint(equalTo: loadingModalView.topAnchor, constant: 20).isActive = true
        verticalStack.rightAnchor.constraint(equalTo: loadingModalView.rightAnchor, constant: -12).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: loadingModalView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func setupLocalizedTexts(){
        var information = self.dialogInfo
        if information == nil {
            information = DialogInfo(title: "Wait Moment")
        }
        
        self.titleDialogLabel.text = information?.title
        self.descriptionDialogLabel.text = information?.description
        self.activityIndicator.color = information?.color
    }
}

extension UIView {
    func addShadow(color: UIColor = UIColor.lightGray, masksToBounds: Bool = false, opacity: Float = 0.23, shadowRadius: CGFloat = 2, offset: CGSize = .zero, radius: CGFloat = 7){
        layer.shadowColor = color.cgColor
        layer.masksToBounds = masksToBounds
        layer.shadowOpacity = opacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.cornerRadius =  radius
    }
    
}

