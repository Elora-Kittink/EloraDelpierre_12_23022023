//  KittenCardPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

/// `KittenCardPresenter` acts as the middleman between the `KittenCardInteractor` and `KittenCardViewModel`.
/// It processes data received from the interactor and updates the ViewModel.
class KittenCardPresenter: Presenter<KittenCardViewModel> {
	
	/// Updates the ViewModel with kitten and litter details.
	/// - Parameters:
	///   - kitten: The `Kitten` object to be displayed.
	///   - litter: The `Litter` object associated with the kitten.
	func display(kitten: Kitten, litter: Litter) {
		// Updates the ViewModel with information about the kitten and its associated litter.
		// This includes setting up various properties such as kitten's name, birthdate, color, etc.
		self.viewModel?.infoCardViewModel = [
			InfoCardViewModel(label: kitten.birthdate?.toString(format: "dd/MM/yyyy"),
							  imageContent: UIImage(named: "birthdate")),
			
			InfoCardViewModel(label: kitten.rescueDate?.toString(format: "dd/MM/yyyy"),
							  imageContent: UIImage(named: "rescueDate")),
			
			InfoCardViewModel( label: kitten.color,
							   imageContent: UIImage(named: "color")),
			
			InfoCardViewModel(label: kitten.adopters?.lastName,
							  imageContent: UIImage(named: "adopters"))
		]
		
		self.viewModel?.firstName = kitten.firstName ?? "?"
		self.viewModel?.secondName = kitten.secondName ?? "?"
		self.viewModel?.birthdate = kitten.birthdate?.toString(format: "dd/MM/yyyy") ?? "?"
		let age = kitten.birthdate?.timeIntervalSinceNow
		self.viewModel?.age = "\(abs(Int((age ?? 0) / 31_556_926.0)))"
		self.viewModel?.sex = kitten.sex ?? "?"
		self.viewModel?.color = kitten.color ?? "?"
		self.viewModel?.rescueDate = kitten.rescueDate?.toString(format: "dd/MM/yyyy") ?? "?"
		let siblings = litter.kittens?.filter { kitty in
			kitten.id != kitty.id
		}
		self.viewModel?.siblings = siblings?.compactMap { sibling in
			sibling.firstName
		}
		.joined(separator: ", ") ?? "?"
		
		self.viewModel?.comment = kitten.comment ?? "?"
		self.viewModel?.isAdopted = kitten.isAdopted
		self.viewModel?.microship = String(kitten.microship ?? 0)
		self.viewModel?.tattoo = kitten.tattoo
		self.viewModel?.vaccines = kitten.vaccines ?? []
		self.viewModel?.adopters = "\(kitten.adopters?.firstName ?? "") \(kitten.adopters?.lastName ?? "")"
		self.viewModel?.weightHistory = kitten.weighingHistory ?? []
		self.viewModel?.isAlive = kitten.isAlive
		
		self.viewModel?.kitten = kitten
		
		self.viewModel?.send()
	}
}
