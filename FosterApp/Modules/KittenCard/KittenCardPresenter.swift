//  KittenCardPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

class KittenCardPresenter: Presenter<KittenCardViewModel> {
    
    func display(kitten: Kitten) {
        self.viewModel?.firstName = kitten.firstName ?? ""
        self.viewModel?.secondName = kitten.secondName ?? ""
        self.viewModel?.birthdate = kitten.birthdate?.toString(format: "dd/MM/yyyy") ?? ""
        self.viewModel?.age =
        self.viewModel?.sex = kitten.sex ?? ""
        self.viewModel?.color = kitten.color ?? ""
        self.viewModel?.rescueDate = kitten.rescueDate?.toString(format: "dd/MM/yyyy") ?? ""
        self.viewModel?.siblings = kitten.siblings?.compactMap { sibling in
            return sibling.firstName
        }.joined(separator: ",") ?? ""
        self.viewModel?.comment = kitten.comment ?? ""
        self.viewModel?.isAdopted = kitten.isAdopted
        self.viewModel?.microship = String(kitten.microship ?? 0)
        self.viewModel?.isTestsDone = kitten.isTestsDone
        self.viewModel?.vaccines = kitten.vaccines ?? []
        self.viewModel?.adopters = "\(kitten.adopters?.firstName) \(kitten.adopters?.lastName)"
        self.viewModel?.weightHistory = kitten.weightHistory ?? []
//        self.viewModel?.isFieldsEnabled =
        self.viewModel?.isAlive = kitten.isAlive
        guard let litter = kitten.litter else { return}
        self.viewModel?.litter = litter
    }
}
