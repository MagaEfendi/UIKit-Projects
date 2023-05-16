//
//  HomeHeaderView.swift
//  Starbucks
//
//  Created by Mahammad Afandiyev on 16.05.23.
//

import UIKit

protocol HomeHeaderViewDelegate: AnyObject {
    func didHistoryButtonTapped(_ sender: HomeHeaderView)
}

class HomeHeaderView : UIView {
    
    let greeting = UILabel()
    let inboxButton = UIButton()
    let historyButton = UIButton()
    
    weak var delegate: HomeHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHeaderView {
    func style() {
        greeting.translatesAutoresizingMaskIntoConstraints = false
        greeting.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        greeting.text = "Good afternoon, Maga How are you?"
        greeting.numberOfLines = 0
        greeting.lineBreakMode = .byWordWrapping
        
        
        
        makeInboxbutton()
        makeCalendarButton()
        
        historyButton.addTarget(self, action: #selector(historyButtonTapped(sender:)), for: .primaryActionTriggered)
    }
    
    func layout() {
        addSubview(greeting)
        addSubview(inboxButton)
        addSubview(historyButton)
        
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            greeting.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: greeting.trailingAnchor, multiplier: 1),
            
            inboxButton.leadingAnchor.constraint(equalToSystemSpacingAfter: greeting.leadingAnchor, multiplier: 0.5),
            inboxButton.topAnchor.constraint(equalToSystemSpacingBelow: greeting.bottomAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: inboxButton.bottomAnchor, multiplier: 1),
            inboxButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            
            historyButton.leadingAnchor.constraint(equalToSystemSpacingAfter: inboxButton.trailingAnchor, multiplier: 1.5),
            historyButton.topAnchor.constraint(equalToSystemSpacingBelow: greeting.bottomAnchor, multiplier: 1),
            historyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25)
        ])
    }
}

extension HomeHeaderView {
    func makeInboxbutton() {
        inboxButton.translatesAutoresizingMaskIntoConstraints=false
        let configuration = UIImage.SymbolConfiguration (scale: .large)
        let image = UIImage(systemName: "envelope", withConfiguration: configuration)
        
        inboxButton.setImage (image, for: .normal)
        inboxButton.imageView?.tintColor = .secondaryLabel
        inboxButton.imageView?.contentMode = .scaleAspectFit
        
        inboxButton.setTitle("Inbox", for: .normal)
        inboxButton.setTitleColor(.secondaryLabel,for:.normal)
        
        inboxButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        inboxButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func makeCalendarButton() {
        historyButton.translatesAutoresizingMaskIntoConstraints=false
        let configuration = UIImage.SymbolConfiguration (scale: .large)
        let image = UIImage(systemName: "calendar", withConfiguration: configuration)
        
        historyButton.setImage (image, for: .normal)
        historyButton.imageView?.tintColor = .secondaryLabel
        historyButton.imageView?.contentMode = .scaleAspectFit
        
        historyButton.setTitle("History", for: .normal)
        historyButton.setTitleColor(.secondaryLabel,for:.normal)
        
        historyButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        historyButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func historyButtonTapped(sender: UIButton) {
        delegate?.didHistoryButtonTapped(self)
    }
}

