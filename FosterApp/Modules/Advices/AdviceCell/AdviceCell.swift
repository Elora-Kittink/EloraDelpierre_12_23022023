//
//  AdviceCell.swift
//  FosterApp
//
//  Created by Elora on 30/10/2023.
//

import Foundation
import UtilsKit

/// `AdviceCell` is a subclass of `BaseTableViewCell` designed to display a piece of advice in a table view.
class AdviceCell: BaseTableViewCell {
	
	// MARK: - Outlets
	
	/// Label to display the advice text.
	@IBOutlet private weak var label: UILabel!
	
	// MARK: - Variables

	/// The text content for the cell. Setting this updates the label's text.
	var text: String! {
		didSet {
			self.label.text = self.text
		}
	}
}

// MARK: - ViewReusable

/// Extension to conform to `ViewReusable` protocol, providing a reusable identifier.
extension AdviceCell: ViewReusable {
	
	/// The reuse identifier for `AdviceCell`.
	static var identifier: String {
		"AdviceCell"
	}
}
