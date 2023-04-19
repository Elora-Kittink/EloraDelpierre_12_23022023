//  HomePresenter.swift
//
//  Created by Elora on 27/02/2023.
//

class HomePresenter: Presenter<HomeViewModel> {
    
    func noUserConnected() {
        self.viewModel?.isUserConnected = false
    }
    
    func presentUserConnected(user: User) {
        self.viewModel?.user = user
    }
    
    func display() {
        self.viewModel?.userName = self.viewModel?.user?.name
        
        self.viewModel?.send()
    }
    
    func displayLoginPage() {
        LoginViewController.fromStoryboard().push()
    }
}
