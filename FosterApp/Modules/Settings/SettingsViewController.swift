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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen,with: ["page": "\(Self.self)"])
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
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"logout"])
									
		self.interactor.logOut()
	}
	
	@IBAction private func didTapEditButton() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"edit_photo"])
										
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
