//  HomePresenter.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit

class HomePresenter: Presenter<HomeViewModel> {
    
    func noUserConnected() {
        self.viewModel?.isUserConnected = false
        LoginViewController.fromStoryboard().modal(withNavigationController: true)
    }
    
    func presentUserConnected(user: User) {
        self.viewModel?.user = user
		self.viewModel?.isUserConnected = true
        self.viewModel?.send()
    }
	
//    
//    func display() {
//        self.viewModel?.userName = self.viewModel?.user?.name
//        
//        self.viewModel?.send()
//    }
}
