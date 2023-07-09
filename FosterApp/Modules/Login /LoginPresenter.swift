//  LoginPresenter.swift
//
//  Created by Elora on 29/03/2023.
//

class LoginPresenter: Presenter<LoginViewModel> {
	
	func display(user: User) {
		self.viewModel?.userConnected = user
	}
}
