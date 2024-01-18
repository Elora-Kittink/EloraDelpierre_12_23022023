//  HomePresenter.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit

/// `HomePresenter` acts as the middleman between the `HomeInteractor` and `HomeViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class HomePresenter: Presenter<HomeViewModel> {
    
	/// Updates the ViewModel to reflect that no user is currently connected and presents the login screen.
    func noUserConnected() {
        self.viewModel?.isUserConnected = false
        LoginViewController.fromStoryboard().modal(withNavigationController: true)
    }
    
	/// Updates the ViewModel with the connected user's information.
	/// - Parameter user: The `User` object representing the logged-in user.
    func presentUserConnected(user: User) {
        self.viewModel?.user = user
		self.viewModel?.isUserConnected = true
        self.viewModel?.send()
    }
}
