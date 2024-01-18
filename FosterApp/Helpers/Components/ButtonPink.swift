//
//  ButtonPrimary.swift
//  FosterApp
//
//  Created by Elora on 01/09/2023.
//

import Foundation
import UIKit

// custom button to reuse
class ButtonPink: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
//	configuration
    private func setupButton() {
      
        backgroundColor = UIColor(named: "pink")
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(withHexString: "#7E6360")?.cgColor
        
        
        layer.cornerRadius = 4.0
        
   
        setTitleColor(UIColor(withHexString: "#7E6360"), for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
