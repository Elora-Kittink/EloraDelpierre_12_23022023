//
//  BaseTableView.swift
//  FosterApp
//
//  Created by Elora on 13/07/2023.
//

import Foundation
import UIKit


/// A generic UITableView subclass that simplifies the setup of table views using generic cell types.
/// - Parameters:
///   - T: The cell type (subclass of `BaseCell`).
///   - U: The model type that the cell will display.
class BaseTableView<T: BaseCell<U>, U>: UITableView, UITableViewDelegate, UITableViewDataSource {
	
	// Identifier for cell reuse.
	let cellId = "BaseCellID"
	
	// Array of items (models) that the table view will display.
	var items = [U]() {
		didSet {
			reloadData()
		}
	}
	
	// Closure type for handling cell selection.
	typealias DidSelectClosure = ((U, IndexPath) -> Void)? // just being fancy here
	
	// Closure to be called when a cell is selected.
	let didSelect: DidSelectClosure
	
	/// Initializes a new instance of the table view.
	/// - Parameter didSelect: A closure that is called when a cell is selected.
	init(didSelect: DidSelectClosure) {
		self.didSelect = didSelect
		super.init(frame: CGRect.zero, style: .plain)
		register(T.self, forCellReuseIdentifier: cellId)
		delegate = self
		dataSource = self
	}
	
	/// Required initializer for the `BaseTableView` class when using Storyboards or XIBs.
	/// This initializer is marked as unavailable because `BaseTableView` is designed to be used programmatically.
	/// Attempting to initialize `BaseTableView` through Storyboards or XIBs will result in a runtime error.
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BaseCell<U>
		cell?.item = items[indexPath.row]
		return cell ?? UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	didSelect?(items[indexPath.row], indexPath)
	}
}

/// A generic UITableViewCell subclass that can be configured with any model type.
/// - Parameter U: The model type that the cell will display.
class BaseCell<U>: UITableViewCell {
	var item: U?
}
