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
    @IBOutlet private weak var stackInfoCards: UIStackView!

    
    // MARK: - Variables
    
    var litterId = ""
    var litter: Litter!
    var kitten: Kitten!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.refresh(kitten: self.kitten, litter: self.litter)
    }
    
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
            
        self.nameLabel.text = self.viewModel.firstName
        self.microshipLabel.text = self.viewModel.microship
        self.viewModel.infoCardViewModel.forEach { info in
            let view = InfoCardView.fromNib()
            view.viewModel = info
            stackInfoCards.addArrangedSubview(view)
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
		navigationController?.present(vc, animated: true)
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
