//  SettingsViewModel.swift
//
//  Created by Elora on 06/11/2023.
//

/// `SettingsViewModel` represents the state and data of the `SettingsViewController`.
/// It stores user data and statistics like the count of kittens and milk.
class SettingsViewModel: ViewModel {
	/// The current user's data.
	var user: User?
	/// Flag indicating whether the user is connected.
	var isUserConnected = false
	/// Count of kittens associated with the user.
	var kittensCount = 123
	/// Count of milk entries associated with the user.
	var milkCount = 123
}
