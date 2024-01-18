//  ViewModel.swift
//
//  Created by Elora on 27/02/2023.
//

import Combine

/// `ViewModel` serves as the data model for the view.
/// It is an observable object that notifies views of changes.
class ViewModel: ObservableObject {
	
	// MARK: - Variables
	var isLoading: Bool?
	var needToClose = false
    
    // MARK: - Init
    required init() { }
    
	/// Notifies observers about changes in the ViewModel.
    func send() {
        self.objectWillChange.send()
    }
}
