//  SettingsPresenter.swift
//
//  Created by Elora on 06/11/2023.
//

/// `SettingsPresenter` acts as the middleman between the `SettingsInteractor` and `SettingsViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class SettingsPresenter: Presenter<SettingsViewModel> {
	
	/// Updates the ViewModel with settings data and triggers a UI refresh in the associated view controller.
	/// - Parameters:
	///   - kittens: An array of `Kitten` objects to be displayed.
	///   - weighings: An array of `Weighing` objects to be displayed.
	///   - user: The current `User` object.

	func display(kittens: [Kitten], weighings: [Weighing], user: User) {
		// Update ViewModel with data and trigger UI refresh
		self.viewModel?.user = user
		self.viewModel?.isUserConnected = true
		
		self.viewModel?.kittensCount = kittens.count
		self.viewModel?.milkCount = weighings.count
		
		self.viewModel?.send()
	}
	/// Handles the scenario where no user is connected.
	func noUserConnected() {
		self.viewModel?.isUserConnected = false
		LoginViewController.fromStoryboard().modal(withNavigationController: true)
	}
}
