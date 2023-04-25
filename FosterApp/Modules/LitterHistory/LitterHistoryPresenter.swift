//  LitterHistoryPresenter.swift
//
//  Created by Elora on 27/02/2023.
//

class LitterHistoryPresenter: Presenter<LitterHistoryViewModel> {
    
    func display(litters: [Litter]) {
        self.viewModel?.litters = litters
    }
    
    func displayCell(litter: Litter) {
        self.viewModel?.kittenList = litter.kittens?.compactMap { kitten in
            kitten.firstName
        }.joined(separator: ", ") ?? "Pas encore de chaton"
    
    }
}
