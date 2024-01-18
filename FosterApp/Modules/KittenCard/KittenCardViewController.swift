//  KittenCardViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

/// `KittenCardViewController` is a  view controller that manages the display and interaction with a specific kitten's details.
/// This controller inherits from `BaseViewController` and is specialized with `KittenCardViewModel`, `KittenCardPresenter`, and `KittenCardInteractor` for its operation.
class KittenCardViewController: BaseViewController<KittenCardViewModel, KittenCardPresenter, KittenCardInteractor> {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var microshipLabel: UILabel!
	@IBOutlet private weak var tattooLabel: UILabel!
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
	@IBOutlet private weak var comment: UITextView!
	@IBOutlet private weak var documentsTile: Tile!
	@IBOutlet private weak var galleryTile: Tile!
	
	// MARK: - Variables
    
    var litterId = ""
    var litter: Litter!
    var kitten: Kitten!
    
    // MARK: - View life cycle
	
	/// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
//		return from the form with the new kitten by the presenter.close() way
		// Adds an observer for the 'newKittenCreated' notification.
		// This observer is triggered when a new kitten is created from the form.
		// It calls the `refresh` method on the interactor to update the view with the new kitten's details.
		NotificationCenter.default.addObserver(forName: NSNotification.Name("newKittenCreated"),
											   object: nil,
											   queue: nil) { [interactor] _ in
			interactor.refresh(kitten: self.kitten, litter: self.litter)
		}
//		return from the form with the updated kitten by the presenter.close() way
		// Adds an observer for the 'kittenUpdated' notification.
		// This observer is triggered when an existing kitten's details are updated from the form.
		// It extracts the updated kitten object from the notification and calls the `refresh` method
		// on the interactor to update the view with the updated kitten's details.
		NotificationCenter.default.addObserver(forName: NSNotification.Name("kittenUpdated"),
											   object: nil,
											   queue: nil) { [weak interactor] notification in
			guard let kittenUpdated = notification.userInfo?["kitten"] as? Kitten else { return }
			interactor?.refresh(kitten: kittenUpdated, litter: self.litter)
		}
		
		self.birthdateGroup.layer.shadowColor = UIColor.gray.cgColor
		self.birthdateGroup.layer.shadowOffset = CGSize(width: 2, height: 4)
		self.birthdateGroup.layer.shadowOpacity = 0.3
		self.birthdateGroup.layer.shadowRadius = 2
		
		self.adopterGroup.layer.shadowColor = UIColor.gray.cgColor
		self.adopterGroup.layer.shadowOffset = CGSize(width: 2, height: 4)
		self.adopterGroup.layer.shadowOpacity = 0.3
		self.adopterGroup.layer.shadowRadius = 2
		
		self.colorGroup.layer.shadowColor = UIColor.gray.cgColor
		self.colorGroup.layer.shadowOffset = CGSize(width: 2, height: 4)
		self.colorGroup.layer.shadowOpacity = 0.3
		self.colorGroup.layer.shadowRadius = 2
		
		self.comment.layer.cornerRadius = 10
		self.comment.layer.shadowColor = UIColor.gray.cgColor
		self.comment.layer.shadowOffset = CGSize(width: 2, height: 4)
		self.comment.layer.shadowOpacity = 0.3
		self.comment.layer.shadowRadius = 2
		
        self.title = self.viewModel.title
        self.interactor.refresh(kitten: self.kitten, litter: self.litter)
		self.birthdateGroup.layer.cornerRadius = 12
		self.colorGroup.layer.cornerRadius = 12
		self.adopterGroup.layer.cornerRadius = 12
    }
    
    
    // MARK: - Refresh
	
	/// Refreshes the UI with new data stored in the ViewModel.
    override func refreshUI() {
        super.refreshUI()
            
		self.microshipLabel.isHidden = self.viewModel.microship?.isEmpty ?? true ? true : false
		self.secondNameLabel.isHidden = self.viewModel.secondName.isEmpty ? true : false
		self.tattooLabel.isHidden = true
		self.adopterGroup.isHidden = self.viewModel.isAdopted ? false : true
//		self.viewModel.tattoo?.isEmpty ?? true ? true : false
		self.nameLabel.text = self.viewModel.firstName
		self.secondNameLabel.text = self.viewModel.secondName
		print("🦊\(self.viewModel.tattoo)")
        self.microshipLabel.text = self.viewModel.microship
		self.tattooLabel.text = self.viewModel.tattoo
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
    
	/// Action for editing the kitten's details.
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
    
	/// Action for adding a new weighing record for the kitten.
    @IBAction private func addWeighing() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"add_weight"])
		
		let vc = AddWeightViewController.fromStoryboard { vc in
			vc.kitten = self.viewModel.kitten
		}
		navigationController?.present(vc, animated: true)
    }
	
	/// Action for showing the kitten's weighing history.
	@IBAction private func showWeighingHistory() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"weighing_history"])
		
		let vc = WeighingListViewController.fromStoryboard { vc in
			vc.kitten = self.viewModel.kitten
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: - Storyboard Protocol Conformance
extension KittenCardViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCard"
    }
    
    static var identifier: String? {
        "KittenCardViewController"
    }
}
