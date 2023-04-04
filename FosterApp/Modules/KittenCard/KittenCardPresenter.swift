//  KittenCardPresenter.swift
//
//  Created by Elora on 24/02/2023.
//

import Foundation
import UIKit

class KittenCardPresenter: Presenter<KittenCardViewModel> {
    
    func display(kitten: Kitten, litter: Litter) {
        
        self.viewModel?.firstName = kitten.firstName ?? "A compléter"
        self.viewModel?.secondName = kitten.secondName ?? ""
        self.viewModel?.birthdate = kitten.birthdate?.toString(format: "dd/MM/yyyy") ?? "A compléter"
        let age = kitten.birthdate?.timeIntervalSinceNow
        self.viewModel?.age = "\(abs(Int((age ?? 0) / 31_556_926.0)))"
        self.viewModel?.sex = kitten.sex ?? "A compléter"
        self.viewModel?.color = kitten.color ?? "A compléter"
        self.viewModel?.rescueDate = kitten.rescueDate?.toString(format: "dd/MM/yyyy") ?? "A compléter"
        let siblings = litter.kittens?.filter { kitty in
            kitten.id != kitty.id
        }
        self.viewModel?.siblings = siblings?.compactMap { sibling in
             sibling.firstName
        }
        .joined(separator: ", ") ?? ""

        self.viewModel?.comment = kitten.comment ?? "A compléter"
        self.viewModel?.isAdopted = kitten.isAdopted
        self.viewModel?.microship = String(kitten.microship ?? 0)
        self.viewModel?.vaccines = kitten.vaccines ?? []
        self.viewModel?.adopters = "\(kitten.adopters?.firstName) \(kitten.adopters?.lastName)"
        self.viewModel?.weightHistory = kitten.weightHistory ?? []
        self.viewModel?.isAlive = kitten.isAlive

        self.viewModel?.kitten = kitten
        
        self.viewModel?.send()
    }
}
