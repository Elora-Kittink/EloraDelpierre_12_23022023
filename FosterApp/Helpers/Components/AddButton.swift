//
//  AddButton.swift
//  FosterApp
//
//  Created by Elora on 27/02/2023.
//

import Foundation
import UIKit

class AddButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 25
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
    }
}
