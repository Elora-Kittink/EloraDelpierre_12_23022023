//  SignUpPresenter.swift
//
//  Created by Elora on 30/03/2023.

/// `SignUpPresenter` acts as the middleman between the `SignUpInteractor` and `SignUpViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class SignUpPresenter: Presenter<SignUpViewModel> {
    
	/// Updates the ViewModel with the signed-in user's data.
	/// - Parameter user: The `User` object representing the signed-in user.
	func display(user: User) {
		
		self.viewModel?.userSignedIn = user
    }
}
