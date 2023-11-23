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
	@IBOutlet private weak var editPhoto: UIButton!
	@IBOutlet private weak var editAppIcon: UIButton!
	@IBOutlet private weak var kittensCountLabel: UILabel!
	@IBOutlet private weak var milkCountLabel: UILabel!
	
	// MARK: - Variables
	
	let profilePhoto: UIImageView = {
		let imageView = UIImageView()
  imageView.translatesAutoresizingMaskIntoConstraints = false
  imageView.contentMode = .scaleAspectFill
  imageView.layer.cornerRadius = imageView.bounds.width / 2
  imageView.clipsToBounds = true
  return imageView
}()
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
		self.interactor.refresh()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		
		if let userName = self.viewModel.user?.name {
			self.nameLabel.text = "Bienvenue \(userName)!"
		} else {
			self.nameLabel.text = "Bienvenue !"
		}
		
		self.kittensCountLabel.text = "\(self.viewModel.kittensCount)"
		self.milkCountLabel.text = "\(self.viewModel.milkCount)"
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
	
	@IBAction private func didTapEditAppIconButton() {
		ChooseAppIconViewController.fromStoryboard().modal()
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
