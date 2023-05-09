//  AdvicesPresenter.swift
//
//  Created by Elora on 04/05/2023.
//

class AdvicesPresenter: Presenter<AdvicesViewModel> {
    
    func display(advices: AdvicesResponse, sections: [AdvicesSectionType]) {
        self.viewModel?.advices = advices
        self.viewModel?.sections = sections
        self.viewModel?.send()
    }
}
