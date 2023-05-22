//  AdvicesInteractor.swift
//
//  Created by Elora on 04/05/2023.
//

import Foundation
import UtilsKit

class AdvicesInteractor: Interactor
<
	AdvicesViewModel,
	AdvicesPresenter
> {
    private let adviceWorker = APIWorker()
    
    func refresh() {
        Task {
            do {
                let data = try await adviceWorker.fetchAllAdvices()
                self.presenter.display(sections: data)
            } catch {
                log(.data, "AdvicesInteractor", error: error)
            }
        }
    }
}
