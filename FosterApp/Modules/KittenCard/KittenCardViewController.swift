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
	@IBOutlet private weak var comment: UILabel!
	@IBOutlet private weak var documentsTile: Tile!
	@IBOutlet private weak var galleryTile: Tile!
	
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
		self.comment.text = self.viewModel.comment
        self.viewModel.infoCardViewModel.forEach { info in
            let view = InfoCardView.fromNib()
            view.viewModel = info
//            stackInfoCards.addArrangedSubview(view)
        }
    }
    
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen,with: ["page": "\(Self.self)"])
	}
	
    // MARK: - Actions
    
    @IBAction private func edit() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"edit"])
		
		let vc = KittenCardModalViewController.fromStoryboard { vc in
			vc.litter = self.litter
			vc.kitten = self.kitten
			vc.isCreatingMode = false
			vc.isEditingMode = true
		}
        navigationController?.present(vc, animated: true)
    }
    
    @IBAction private func addWeighing() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"add_weight"])
		
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.viewModel.kitten
		}
		navigationController?.present(vc, animated: true)
    }
	
	@IBAction private func showWeighingHistory() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"weighing_history"])
		
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
