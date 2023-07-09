//  SignUpPresenter.swift
//
//  Created by Elora on 30/03/2023.


class SignUpPresenter: Presenter<SignUpViewModel> {
    
	func display(user: User) {
		
		self.viewModel?.userSignedIn = user
    }
}
