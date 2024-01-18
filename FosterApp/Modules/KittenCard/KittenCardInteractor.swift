//  KittenCardInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

/// `KittenCardInteractor` handles the business logic for the `KittenCardViewController`.
class KittenCardInteractor: Interactor
<
    KittenCardViewModel,
    KittenCardPresenter
> {
    let worker = DBWorker()

	/// Refreshes the kitten card with the given kitten and litter details.
	/// - Parameters:
	///   - kitten: The `Kitten` object to be displayed.
	///   - litter: The `Litter` object associated with the kitten.
    func refresh(kitten: Kitten, litter: Litter) {
        self.presenter.display(kitten: kitten, litter: litter)
		self.presenter.display(loader: false)
    }
}
