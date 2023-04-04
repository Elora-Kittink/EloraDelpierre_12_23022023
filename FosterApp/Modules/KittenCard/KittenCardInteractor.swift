//  KittenCardInteractor.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

class KittenCardInteractor: Interactor
<
    KittenCardViewModel,
    KittenCardPresenter
> {
    let worker = Worker()

    func refresh(kitten: Kitten, litter: Litter) {
        self.presenter.display(kitten: kitten, litter: litter)
    }
}
