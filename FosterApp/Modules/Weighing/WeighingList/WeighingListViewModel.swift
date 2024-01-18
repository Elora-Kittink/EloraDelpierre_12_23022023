//  WeighingListViewModel.swift
//
//  Created by Elora on 09/07/2023.
//

/// `WeighingListViewModel` represents the state and data of the `WeighingListViewController`.
class WeighingListViewModel: ViewModel {
	/// Array of weighing data to be displayed.
	var weights: [Weighing]?
	/// Label for the columns in the weighing list.
	var firstColumnLabel = "Date"
	var secondColumnLabel = "Chaton"
	var thirdColumnLabel = "Lait"
    
    let title = "Historique des pesées"
}
