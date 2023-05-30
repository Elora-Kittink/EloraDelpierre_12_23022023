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
    
    func refresh(url: URL?) {
        guard let url else {
            self.presenter.display(loader: false)
            return
        }
        Task {
                let data = await adviceWorker.fetchAllAdvices(url: url)
                self.presenter.display(sections: data)
                self.presenter.display(loader: false)
        }
    }
}
