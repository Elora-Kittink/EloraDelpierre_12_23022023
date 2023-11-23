//  SettingsPresenter.swift
//
//  Created by Elora on 06/11/2023.
//

class SettingsPresenter: Presenter<SettingsViewModel> {
	
	func display(kittens: [Kitten], weighings: [Weighing], user: User) {
		self.viewModel?.user = user
		self.viewModel?.isUserConnected = true
		
		self.viewModel?.kittensCount = kittens.count
		self.viewModel?.milkCount = weighings.count
		
		self.viewModel?.send()
	}
	
	func noUserConnected() {
		self.viewModel?.isUserConnected = false
		LoginViewController.fromStoryboard().modal(withNavigationController: true)
	}
}
