//  LoaderView.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit

class LoaderView: UIView {
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		self.setup()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		self.setup()
	}
	
	func setup() { }
	
	// MARK: - Functions
	func play() {
		self.isHidden = false
	}
	
	func stop() {
		self.isHidden = true
	}
}
