//
//  BaseTableView.swift
//  FosterApp
//
//  Created by Elora on 13/07/2023.
//

import Foundation
import UIKit

class BaseTableView<T: BaseCell<U>, U>: UITableView, UITableViewDelegate, UITableViewDataSource {
	
	let cellId = "BaseCellID"
	
	var items = [U]() {
		didSet {
			reloadData()
		}
	}
	
	typealias DidSelectClosure = ((U, IndexPath) -> Void)? // just being fancy here
	
	let didSelect: DidSelectClosure
	
	init(didSelect: DidSelectClosure) {
		self.didSelect = didSelect
		super.init(frame: CGRect.zero, style: .plain)
		register(T.self, forCellReuseIdentifier: cellId)
		delegate = self
		dataSource = self
	}
	
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

class BaseCell<U>: UITableViewCell {
	var item: U?
}
