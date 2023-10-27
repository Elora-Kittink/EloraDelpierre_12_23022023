//  KittenCardViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

class KittenCardViewController: BaseViewController<KittenCardViewModel, KittenCardPresenter, KittenCardInteractor> {
    
    // MARK: - Outlets
    
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var microshipLabel: UILabel!
    @IBOutlet private weak var weightHistory: UIView!
    @IBOutlet private weak var medicalHistory: UIView!
    @IBOutlet private weak var editBtn: UIButton!
    @IBOutlet private weak var imageView: UIView!
    @IBOutlet private weak var image: UIImageView!
	@IBOutlet private weak var birthdate: UILabel!
	@IBOutlet private weak var color: UILabel!
	@IBOutlet private weak var secondNameLabel: UILabel!
	@IBOutlet private weak var adopterGroup: UIView!
	@IBOutlet private weak var colorGroup: UIView!
	@IBOutlet private weak var birthdateGroup: UIView!
	
	@IBOutlet weak var documentsTile: Tile!
	@IBOutlet weak var galleryTile: Tile!
	
	// MARK: - Variables
    
    var litterId = ""
    var litter: Litter!
    var kitten: Kitten!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.title
        self.interactor.refresh(kitten: self.kitten, litter: self.litter)
		self.birthdateGroup.layer.cornerRadius = 12
		self.colorGroup.layer.cornerRadius = 12
		self.adopterGroup.layer.cornerRadius = 12
		
		self.galleryTile.style = .kitten
		self.documentsTile.style = .kitten
    }
    
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
            
		self.microshipLabel.isHidden = self.viewModel.microship?.isEmpty ?? true ? true : false
		self.secondNameLabel.isHidden = self.viewModel.secondName.isEmpty ?? true ? true : false
		
		self.nameLabel.text = self.viewModel.firstName.isEmpty ? "Pas encore de nom" : self.viewModel.firstName
		
        self.microshipLabel.text = self.viewModel.microship
		
		self.birthdate.text = self.viewModel.birthdate
		self.color.text = self.viewModel.color
		
        self.viewModel.infoCardViewModel.forEach { info in
            let view = InfoCardView.fromNib()
            view.viewModel = info
//            stackInfoCards.addArrangedSubview(view)
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func edit() {
		let vc = KittenCardModalViewController.fromStoryboard { vc in
			vc.litter = self.litter
			vc.kitten = self.kitten
			vc.isCreatingMode = false
			vc.isEditingMode = true
		}
        navigationController?.present(vc, animated: true)
    }
    
    @IBAction private func addWeighing() {
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.viewModel.kitten
		}
		navigationController?.present(vc, animated: true)
    }
	
	@IBAction private func showWeighingHistory() {
		let vc = WeighingListViewController.fromStoryboard { vc in
			vc.kitten = self.viewModel.kitten
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}

extension KittenCardViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCard"
    }
    
    static var identifier: String? {
        "KittenCardViewController"
    }
}
