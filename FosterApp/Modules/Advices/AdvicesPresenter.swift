//  AdvicesPresenter.swift
//
//  Created by Elora on 04/05/2023.
//

class AdvicesPresenter: Presenter<AdvicesViewModel> {
    
    func display(sections: AdvicesResponse) {

        self.viewModel?.sections = sections
        self.viewModel?.send()
    }
}
