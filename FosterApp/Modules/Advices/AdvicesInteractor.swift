//  AdvicesInteractor.swift
//
//  Created by Elora on 04/05/2023.
//

import Foundation

class AdvicesInteractor: Interactor
<
	AdvicesViewModel,
	AdvicesPresenter
> {
    
    func loadAdvices() {
        guard let path = Bundle.main.url(forResource: "Advices", withExtension: "json") else {
            return
        }
        do {
            let datas = try Data(contentsOf: path)
            let sectionsAdvices = try JSONDecoder().decode(AdvicesResponse.self, from: datas)
            self.presenter.display(sections: sectionsAdvices)
        } catch {
            print(error)
            print("👹 Fail to decode Advices datas")
        }
    }
    
    func loadSections() {

    }
}
