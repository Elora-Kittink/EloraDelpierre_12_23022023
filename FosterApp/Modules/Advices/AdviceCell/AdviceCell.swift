//
//  AdviceCell.swift
//  FosterApp
//
//  Created by Elora on 30/10/2023.
//

import Foundation
import UtilsKit

class AdviceCell: BaseTableViewCell {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var label: UILabel!
	
	// MARK: - Variables
	var text: String! {
		didSet {
			self.label.text = self.text
		}
	}
}

// MARK: - ViewReusable
extension AdviceCell: ViewReusable {
	
	static var identifier: String {
		"AdviceCell"
	}
}
