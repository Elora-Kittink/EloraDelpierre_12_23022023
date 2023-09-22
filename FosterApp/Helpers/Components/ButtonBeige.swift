//
//  ButtonBeige.swift
//  FosterApp
//
//  Created by Elora on 01/09/2023.
//

import Foundation
import UIKit

class ButtonBeige: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
    
        backgroundColor = UIColor(named: "beige")
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.systemBrown.cgColor
        
        layer.cornerRadius = 4.0
     
        setTitleColor(UIColor.systemBrown, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
