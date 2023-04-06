//  InfoCardView.swift
//
//  Created by Elora on 05/04/2023.
//

import UIKit
import UtilsKit

class InfoCardView: UIView, NibProtocol {
	
	// MARK: - Outlets
	
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var image: UIImageView!
    
	// MARK: - Variables
	
    var viewModel: InfoCardViewModel! {
        didSet {
            self.label.text = self.viewModel.label
            self.image.image = self.viewModel.imageContent
        }
    }
}
