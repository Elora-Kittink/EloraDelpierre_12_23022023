//
//  Tile.swift
//  FosterApp
//
//  Created by Elora on 04/10/2023.
//

import Foundation
import UIKit
import UtilsKit

// custom collectionview cell
class Tile: BaseCollectionViewCell {
//	computed variable for image view
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit

		return imageView
	}()
	
//	computed variable for label
	let label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.adjustsFontForContentSizeCategory = true
		label.font = UIFont.preferredFont(forTextStyle: .body)
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()
	
//	initialisation w UI
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layer.cornerRadius = 15
		
		layer.shadowColor = UIColor.gray.cgColor
				layer.shadowOffset = CGSize(width: 2, height: 4)
				layer.shadowOpacity = 0.3
				layer.shadowRadius = 2
		
		addSubview(imageView)
		addSubview(label)
		
		NSLayoutConstraint.activate([
			//				Image
			imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
			imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
			imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
			imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -4),
			//						Label
			
			label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
			label.heightAnchor.constraint(equalToConstant: 38)
		])
	}
//	requied initialisation
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
//	call to set computed variable img & label
	func configure(image: UIImage, text: String) {
		imageView.image = image
		label.text = text
		self.backgroundColor = UIColor(named: "border")
//		view.layer.cornerRadius = 10
	}
}

// TODO: commenter quand je serais sure de garder
enum Tiles {
	
	case litters, advices, gallery, admin, calendar, contacts, medicalHistory, weighingHistory
	
	var image: UIImage? {
		switch self {
		case .litters:
			return UIImage(named: "litter")
		case .advices:
			return UIImage(named: "advices")
		case .gallery:
			return UIImage(named: "photo")
		case .admin:
			return UIImage(named: "medicalFolders")
		case .calendar:
			return UIImage(named: "calendar")
		case .contacts:
			return UIImage(named: "directory")
		case .medicalHistory:
			return UIImage(named: "medicalFolders")
		case .weighingHistory:
			return UIImage(named: "weight")
		}
	}
	
	var title: String {
		switch self {
		case .litters:
			return "Toutes les portées"
		case .advices:
			return "Conseils"
		case .gallery:
			return "Gallerie"
		case .admin:
			return "Administratif"
		case .calendar:
			return "Agenda"
		case .contacts:
			return "Contacts"
		case .medicalHistory:
			return "Historique médical"
		case .weighingHistory:
			return "Historique de pesées"
		}
	}
}

class BaseCollectionViewCell: UICollectionViewCell {
	
	// MARK: - Localize
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.localize()
	}
}
