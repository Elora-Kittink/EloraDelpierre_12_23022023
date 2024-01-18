//
//  BaseTableViewCell.swift
//  FosterApp
//
//  Created by Elora on 30/10/2023.
//

import Foundation
import UIKit

// TODO: indispensable? commenter
class BaseTableViewCell: UITableViewCell {
	
	// MARK: - Localize
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.localize()
	}
}
