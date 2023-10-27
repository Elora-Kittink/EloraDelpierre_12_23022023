//
//  Tile.swift
//  FosterApp
//
//  Created by Elora on 04/10/2023.
//

import Foundation
import UIKit

@IBDesignable
class Tile: UIView {
	
	var action: (() -> Void)?
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var imageView: UIImageView!
	
	@IBInspectable var image: UIImage? {
		didSet {
			self.imageView.image = self.image
		}
	}
	
	@IBInspectable var title: String? {
		didSet {
			self.titleLabel.text = self.title
		}
	}
	
	@IBInspectable var backGroundColor: UIColor? {
		didSet {
			self.backgroundColor = self.backGroundColor
		}
	}
	var style: TileStyle = .home {
			didSet {
				updateStyle()
			}
		}
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}
	
	private func setup() {
		self.xibSetup()
		self.addGestureRecognizer(UITapGestureRecognizer(target: self,
														 action: #selector(self.tileAction)))
		
		self.imageView.contentMode = .scaleAspectFit
		self.addSubview(imageView)
//		imageView.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint.activate([
//			imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//			imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//		])
//
//		NSLayoutConstraint.activate([
//					titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
//					titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//					titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
//					titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//				])

		
		self.layer.cornerRadius = 12
		self.imageView.image = self.image
		self.titleLabel.text = self.title
		self.titleLabel.textAlignment = .center
		self.titleLabel.numberOfLines = 0
		self.layer.shadowOffset = CGSize(width: 4, height: 4)
		self.layer.shadowOpacity = 0.5
		self.layer.shadowRadius = 4
		self.layer.shadowColor = UIColor.lightGray.cgColor
		
		self.imageView.isHidden = self.imageView.image == nil ? false : true
	}

	@objc
	private func tileAction() {
		self.action?()
	}
	
	private func updateStyle() {
			frame.size = CGSize(width: style.width, height: style.height)
		}
}

enum TileStyle {
	case home, kitten
	
	var height: CGFloat {
		switch self {
		case .home:
			return 200
		case .kitten:
			return 150
		}
	}
	
	var width: CGFloat {
		   switch self {
		   case .home:
			   return 150
		   case .kitten:
			   return 90
		   }
	   }
}
