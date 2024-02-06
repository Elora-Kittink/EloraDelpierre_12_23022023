//  SettingsViewController.swift
//
//  Created by Elora on 06/11/2023.
//

import UtilsKit

/// `SettingsViewController` manages the user interface for the application's settings.
/// It allows users to edit their profile photo, change the app icon, and view specific user data.
/// This controller inherits from `BaseViewController` and is specialized with `SettingsViewModel`, 
/// `SettingsPresenter`, and `SettingsInteractor` for its operation.
class SettingsViewController: BaseViewController
<
	SettingsViewModel,
	SettingsPresenter,
	SettingsInteractor
> {
	
	// MARK: - Outlets
	
	
	/// Label displaying the user's name.
	@IBOutlet private weak var nameLabel: UILabel!
	/// Button for editing the profile photo.
	@IBOutlet private weak var editPhoto: UIButton!
	/// Button for changing the app icon.
	@IBOutlet private weak var editAppIcon: UIButton!
	/// Label showing the number of kittens.
	@IBOutlet private weak var kittensCountLabel: UILabel!
	/// Label showing the count of milk meals.
	@IBOutlet private weak var milkCountLabel: UILabel!
	
	// MARK: - Variables
	
	/// Computed variable for profile image with UI constraints.
	let profilePhoto: UIImageView = {
		let imageView = UIImageView()
  imageView.translatesAutoresizingMaskIntoConstraints = false
  imageView.contentMode = .scaleAspectFill
  imageView.layer.cornerRadius = imageView.bounds.width / 2
  imageView.clipsToBounds = true
  return imageView
}()
	
	// MARK: - View life cycle
	/// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.profilePhoto.layer.cornerRadius = profilePhoto.bounds.width / 2
		self.interactor.refresh()
	}
	/// Sends a log to analytics when the page is opened.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	
	/// Refreshes UI with the new data stored in the ViewModel.
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
	/// Logs out the current user and updates the UI accordingly.
	@IBAction private func logOut() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "logout"])
									
		self.interactor.logOut()
	}
	
	/// Presents a UIImagePickerController to allow the user to edit their profile photo.
	@IBAction private func didTapEditButton() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name": "edit_photo"])
										
		let vc = UIImagePickerController()
		vc.sourceType = .photoLibrary
		vc.delegate = self
		vc.allowsEditing = true
		present(vc, animated: true)
	}
	/// Presents the `ChooseAppIconViewController` to allow the user to change the app icon.
	@IBAction private func didTapEditAppIconButton() {
		ChooseAppIconViewController.fromStoryboard().modal()
	}
}

/// Extension for integrating with storyboard via `StoryboardProtocol`.
extension SettingsViewController: StoryboardProtocol {
	static var storyboardName: String {
		"Settings"
	}
	
	static var identifier: String? {
		"SettingsViewController"
	}
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate


/// Extension for handling image picker delegate methods.
extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	/// Sets the profile photo in the `SettingsViewController` with the selected or edited image from the `UIImagePickerController`.
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
			self.profilePhoto.image = image
		}
		
		picker.dismiss(animated: true)
	}

///	dismisses the UIImagePickerController when the user cancels image picking.
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
}
