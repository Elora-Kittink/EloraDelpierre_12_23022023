//  AdvicesInteractor.swift
//
//  Created by Elora on 04/05/2023.
//

import Foundation
import UtilsKit


/// `AdvicesInteractor` is responsible for handling business logic of `AdvicesViewController`.
/// It fetches advice data and communicates with the presenter to update the view model.
class AdvicesInteractor: Interactor
<
	AdvicesViewModel,
	AdvicesPresenter
> {
    private let adviceWorker = APIWorker()
    
	/// Fetches advice data from the provided URL and updates the presenter with the fetched data.
	/// - Parameter url: The URL to fetch advice data from.
    func refresh(url: URL?) {
        guard let url else {
            self.presenter.display(loader: false)
            return
        }
        Task { 
                let data = await adviceWorker.fetchAllAdvices(url: url)
			// Processes the fetched data and updates the presenter.
                self.presenter.display(sections: data)
                self.presenter.display(loader: false)
        }
    }
}
