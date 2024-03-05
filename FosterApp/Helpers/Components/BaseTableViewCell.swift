//
//  BaseTableViewCell.swift
//  FosterApp
//
//  Created by Elora on 30/10/2023.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
	
	// MARK: - Localize
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.localize()
	}
}
