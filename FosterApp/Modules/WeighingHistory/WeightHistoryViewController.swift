//  WeightHistoryViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit

class WeightHistoryViewController: BaseViewController
<
	WeightHistoryViewModel,
	WeightHistoryPresenter,
	WeightHistoryInteractor
> {
	
	// MARK: - Outlets
    @IBOutlet private weak var graphView: UIView!
    @IBOutlet private weak var weightTable: UITableView!

	// MARK: - Variables
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
	}

	// MARK: - Actions
}
