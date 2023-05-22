//
//  BaseTest.swift
//  FosterAppTests
//
//  Created by Elora on 22/05/2023.
//

import Foundation
import Combine
@testable import FosterApp

@MainActor class BaseTest
<
    V: ViewModel,
    P: Presenter<V>,
    I: Interactor<V, P>
> {
    
    
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
    
    private var continuation: CheckedContinuation<Void, Never>?
    
    var subscribers = Set<AnyCancellable>()
    
    private func configureViewModel(for interactor: inout I) {
        self.subscribers.removeAll()
        
        self.viewModel
            .objectWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.checkUI()
            }
            .store(in: &self.subscribers)
        
        interactor.set(viewModel: self.viewModel)
    }
    
    // MARK: - Init
    func fire(completion: (I) -> Void) async {
        await withCheckedContinuation { continuation in
            self.continuation = continuation
            completion(self.interactor)
        }
    }
    
    // MARK: - Refresh
    func checkUI() {
        if self.viewModel.isLoading ?? true { return }
        self.continuation?.resume()
        self.continuation = nil
    }
}
