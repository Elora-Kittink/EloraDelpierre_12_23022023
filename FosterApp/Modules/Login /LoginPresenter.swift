//  LoginPresenter.swift
//
//  Created by Elora on 29/03/2023.
//

/// `LoginPresenter` acts as the middleman between the `LoginInteractor` and `LoginViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class LoginPresenter: Presenter<LoginViewModel> {

	/// Updates the ViewModel with the logged-in user's data.
	/// - Parameter user: The `User` object representing the logged-in user.
	func display(user: User) {
		self.viewModel?.userConnected = user
	}
}
