//  KittenCardModalPresenter.swift
//
//  Created by Elora on 03/04/2023.
//

class KittenCardModalPresenter: Presenter<KittenCardModalViewModel> {
    
    
    func display(kitten: Kitten?) {
        
        self.viewModel?.firstName = kitten?.firstName ?? ""
        self.viewModel?.secondName = kitten?.secondName ?? ""
        self.viewModel?.birthdate = kitten?.birthdate?.toString(format: "dd/MM/yyyy") ?? ""
        let age = kitten?.birthdate?.timeIntervalSinceNow
        self.viewModel?.age = "\(abs(Int((age ?? 0) / 31_556_926.0)))"
        self.viewModel?.color = kitten?.color ?? ""
        self.viewModel?.rescueDate = kitten?.rescueDate?.toString(format: "dd/MM/yyyy") ?? ""
        self.viewModel?.comment = kitten?.comment ?? ""
        self.viewModel?.microship = String(kitten?.microship ?? 0)
        self.viewModel?.adopters = ""

        self.viewModel?.kitten = kitten
        
        guard let sex = kitten?.sex else {
            self.viewModel?.sex = 0
            return
        }
        if sex == "M" {
            self.viewModel?.sex = 0
        }
        if sex == "F" {
            self.viewModel?.sex = 1
        }
        
        guard let isAlive = kitten?.isAlive else {
            self.viewModel?.isAlive = 0
            return
        }
        if isAlive {
            self.viewModel?.isAlive = 0
        } else {
            self.viewModel?.isAlive = 1
        }
        
        self.viewModel?.send()
    }
}
