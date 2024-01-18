//  HomeViewModel.swift
//
//  Created by Elora on 27/02/2023.
//

/// Holds the data required for the `HomeViewController`.
class HomeViewModel: ViewModel {
	
	var user: User?
	var isUserConnected = false
	
	var homeTiles: [Tiles] = [
		.litters,
		.advices,
		.admin,
		.contacts,
		.calendar,
		.gallery
	]
}
