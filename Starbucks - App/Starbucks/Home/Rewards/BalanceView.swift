//
//  BalanceView.swift
//  Starbucks
//
//  Created by Mahammad Afandiyev on 16.05.23.
//

import UIKit

class BalanceView: UIView {
    
    let pointsLabel = UILabel()
    let starView = makeSymbolImageView(systemName: "star.fill")
    let starBalanceLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
        pointsLabel.text = "12"
        pointsLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
        
        starBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        starBalanceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        starBalanceLabel.textColor = .label
        starBalanceLabel.text = "Star balance"
        
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.tintColor = .systemYellow
        starView.contentMode = .scaleAspectFit
    }
    
    func layout() {
        addSubview(pointsLabel)
        addSubview(starView)
        addSubview(starBalanceLabel)
        
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: topAnchor),
            pointsLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            starView.leadingAnchor.constraint(equalTo: pointsLabel.trailingAnchor,constant: -2),
            starView.centerYAnchor.constraint(equalTo: pointsLabel.centerYAnchor, constant: 4),
            starView.heightAnchor.constraint(equalToConstant: 15),
            
            starBalanceLabel.topAnchor.constraint(equalToSystemSpacingBelow: pointsLabel.bottomAnchor, multiplier: 0),
            starBalanceLabel.leadingAnchor.constraint(equalTo: pointsLabel.leadingAnchor),
            starBalanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            starBalanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
   
}


