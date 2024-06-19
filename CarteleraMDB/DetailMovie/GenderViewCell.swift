//
//  GenderViewCell.swift
//  CarteleraMDB
//
//  Created by Adrian San Martin on 06/06/24.
//

import Foundation
import UIKit

class GenderViewCell: UICollectionViewCell {
    
    lazy var labelGender: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = false
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.white.cgColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(labelGender)
        NSLayoutConstraint.activate([
            labelGender.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelGender.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(model: Genres){
        labelGender.text = "  \(model.name?.prefix(9) ?? "family")  "
    }
}
