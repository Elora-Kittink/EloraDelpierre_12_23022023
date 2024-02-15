//  LoginPresenter.swift
//
//  Created by Elora on 29/03/2023.
//

/// `LoginPresenter` acts as the middleman between the `LoginInteractor` and `LoginViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class LoginPresenter: Presenter<LoginViewModel> {

	func display() {
		self.viewModel?.send()
	}
}
