//
//  RewardsTileView.swift
//  Starbucks
//
//  Created by Mahammad Afandiyev on 16.05.23.
//

import UIKit

class RewardsTileView: UIView {
    
    let balanceView = BalanceView()
    var rewardsButton = UIButton()
    let rewardsGraphView = RewardsGraphView()
    let starRewardsView = StarRewardsView()
    var detailsButton = UIButton()
    
    var heightConstraint : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RewardsTileView {
    
    func style() {
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints = false
        starRewardsView.translatesAutoresizingMaskIntoConstraints = false
        
        detailsButton = makeClearButton(withText: "Details")
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .primaryActionTriggered)
        
        makeRewardsOptionButton()
    }
    
    func makeRewardsOptionButton() {
        rewardsButton.translatesAutoresizingMaskIntoConstraints = false
        rewardsButton.addTarget(self, action: #selector(rewardsOptionsTapped), for: .primaryActionTriggered)
        
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        
        rewardsButton.setImage(image, for: .normal)
        rewardsButton.imageView?.tintColor = .label
        rewardsButton.imageView?.contentMode = .scaleAspectFit
        
        rewardsButton.setTitle("Rewards options", for: .normal)
        rewardsButton.setTitleColor(.label, for: .normal)
        rewardsButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        rewardsButton.semanticContentAttribute = .forceRightToLeft
        rewardsButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 0, right: 0)
        rewardsButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
    }
    
    func layout() {
        addSubview(balanceView)
        addSubview(rewardsButton)
        addSubview(starRewardsView)
        addSubview(detailsButton)
        addSubview(rewardsGraphView)
        
        
        heightConstraint = starRewardsView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            balanceView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            balanceView.topAnchor.constraint(equalTo: topAnchor),
            
            rewardsButton.centerYAnchor.constraint(equalTo: balanceView.pointsLabel.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsButton.trailingAnchor, multiplier: 3),
            
            rewardsGraphView.topAnchor.constraint(equalToSystemSpacingBelow: balanceView.bottomAnchor, multiplier: 1),
            rewardsGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardsGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            rewardsGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsGraphView.trailingAnchor, multiplier: 2),
            
            starRewardsView.topAnchor.constraint(equalTo: rewardsGraphView.bottomAnchor, constant: 8),
            starRewardsView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: starRewardsView.trailingAnchor, multiplier: 1),
            heightConstraint!,
            
            detailsButton.topAnchor.constraint(equalToSystemSpacingBelow: starRewardsView.bottomAnchor, multiplier: 2),
            detailsButton.leadingAnchor.constraint(equalTo: balanceView.leadingAnchor),
            bottomAnchor.constraint(equalToSystemSpacingBelow: detailsButton.bottomAnchor, multiplier: 2),
            detailsButton.trailingAnchor.constraint(equalTo: balanceView.trailingAnchor)
            
            
        ])
        
        starRewardsView.isHidden = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        rewardsGraphView.actualFrameWidth = frame.width
        rewardsGraphView.drawRewardsGraph()
    }
    
}

extension RewardsTileView {
    
    @objc func rewardsOptionsTapped() {
        if heightConstraint?.constant == 0 {
            self.chevronUp()
            
            let heightAnimator = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut) {
                self.heightConstraint?.constant = 270
                self.layoutIfNeeded()
            }
            heightAnimator.startAnimation()
            
            let alphaAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
                self.starRewardsView.isHidden = false
                self.starRewardsView.alpha = 1
            }
            alphaAnimator.startAnimation(afterDelay: 0.5)
        } else {
            self.chevronDown()
            
            let animator = UIViewPropertyAnimator(duration: 0.75, curve: .easeInOut){
                self.heightConstraint?.constant = 0
                self.starRewardsView.isHidden = true
                self.starRewardsView.alpha = 0
                self.layoutIfNeeded()
            }
            animator.startAnimation()
        }
    }
    
    @objc func detailsButtonTapped() {
        print("Details button tapped")
    }
    
    private func chevronUp() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.up", withConfiguration: configuration)
        rewardsButton.setImage(image, for: .normal)
    }
    
    private func chevronDown() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)
        rewardsButton.setImage(image, for: .normal)
    }
}
