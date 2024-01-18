//  BaseViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import Foundation
import UIKit
import Combine
import UtilsKit

/// `BaseViewController` is a generic class that serves as the foundation for all ViewControllers in the application.
/// It integrates key components of the Clean Architecture such as ViewModel, Presenter, and Interactor.
/// It also handles view lifecycle, UI updates, and loading processes.
class BaseViewController
<
    V: ViewModel,
    P: Presenter<V>,
    I: Interactor<V, P>
>:
    UIViewController,
	NavigationProtocol {
	
	func viewWillPresent(controller: UIViewController?, completion: @escaping () -> Void) {
		completion()
	}
	
	
    
    // MARK: - Variables
    var navigationSegue: Segue?
    var instanceIdentifier: String?
    var previousViewController: UIViewController?
    
    // MARK: Clean Archi
    var viewModel = V() {
        didSet {
            self.configureViewModel(for: &self.interactor)
        }
    }
    
    lazy var interactor: I = {
        var interactor = I()
        
        self.configureViewModel(for: &interactor)
        
        return interactor
    }()
    
    private var subscribers = Set<AnyCancellable>()
    
    // MARK: - View life cycle
    deinit {
		// Cleanup and notifications
		self.stopLoading()
        NotificationCenter.default.removeObserver(self)
        print("💀 Deinit \(String(describing: self))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.stopLoading()
    }
    
    // MARK: - Configure viewModel
	/// Configures the ViewModel for the Interactor and sets up bindings for UI updates.
    private func configureViewModel(for interactor: inout I) {
        self.subscribers.removeAll()
        
        self.viewModel
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.refreshUI()
            }
            .store(in: &self.subscribers)
        
        interactor.set(viewModel: self.viewModel)
    }
    
    // MARK: - Refresh
	/// Refreshes the UI based on the ViewModel's state.
    func refreshUI() {
        guard !self.viewModel.needToClose else {
            self.viewModel.needToClose = false
            self.dismiss(animated: true)
            return
        }
		
		/// Handling view closing
        if let isLoading = self.viewModel.isLoading {
            if isLoading {
                self.startLoading()
            } else {
                self.stopLoading()
            }
            
            self.viewModel.isLoading = nil
        }
    }
    
    // MARK: - Loading
	/// Starts the loading process (e.g., showing a spinner).
    func startLoading() {
        self.display(loader: true)
    }
    
	/// Stops the loading process.
    func stopLoading() {
        self.display(loader: false)
    }
}

// MARK: - Private Extension for UIViewController
private extension UIViewController {
    
	/// Displays or hides a loader view based on the `loader` flag.
    func display(loader: Bool) {
        let tag = self.hashValue
        
        if loader {
			// Setup and display the loader view
            let loaderView = LoaderView()
            loaderView.tag = tag
            loaderView.play()
            
            self.view.addSubview(loaderView)
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                loaderView.topAnchor.constraint(equalTo: self.view.topAnchor),
                loaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                loaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                loaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        } else {
			// Find and remove the loader view
            guard let loaderView = self.view?.viewWithTag(tag) as? LoaderView
            else { return }
            
            loaderView.stop()
            loaderView.removeFromSuperview()
        }
    }
}

// MARK: - Navigation Extensions
extension BaseViewController {
    
	/// Presents the view controller modally, optionally within a navigation controller.

    func modal(withNavigationController: Bool = false) {
        Segue.modal.present(self, withNavigationController: withNavigationController)
    }
    
	/// Pushes the view controller onto the navigation stack.
    func push() {
        Segue.push.present(self)
    }
}
