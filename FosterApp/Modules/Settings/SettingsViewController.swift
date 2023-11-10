//  SettingsViewController.swift
//
//  Created by Elora on 06/11/2023.
//

import UtilsKit

class SettingsViewController: BaseViewController
<
	SettingsViewModel,
	SettingsPresenter,
	SettingsInteractor
> {
	
	// MARK: - Outlets
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var profilePhoto: UIImageView!
	@IBOutlet private weak var editPhoto: UIButton!
	
	// MARK: - Variables
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.interactor.userIsConnected()
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		
		if let userName = self.viewModel.user?.name {
			self.nameLabel.text = "Bienvenue \(userName)!"
		} else {
			self.nameLabel.text = "Bienvenue !"
		}
	}

	// MARK: - Actions
	
	@IBAction private func logOut() {
		self.interactor.logOut()
	}
	
	@IBAction private func didTapEditButton() {
		let vc = UIImagePickerController()
		vc.sourceType = .photoLibrary
		vc.delegate = self
		vc.allowsEditing = true
		present(vc, animated: true)
	}
}

extension SettingsViewController: StoryboardProtocol {
	static var storyboardName: String {
		"Settings"
	}
	
	static var identifier: String? {
		"SettingsViewController"
	}
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
			self.profilePhoto.image = image
		}
		
		picker.dismiss(animated: true)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
}
