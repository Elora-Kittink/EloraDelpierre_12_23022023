//  SettingsPresenter.swift
//
//  Created by Elora on 06/11/2023.
//

class SettingsPresenter: Presenter<SettingsViewModel> {
	
	func noUserConnected() {
		self.viewModel?.isUserConnected = false
		LoginViewController.fromStoryboard().modal(withNavigationController: true)
	}
	
	func presentUserConnected(user: User) {
		self.viewModel?.user = user
		self.viewModel?.isUserConnected = true
		self.viewModel?.send()
	}
}
