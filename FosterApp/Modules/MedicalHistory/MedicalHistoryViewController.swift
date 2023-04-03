//  MedicalHistoryViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit

class MedicalHistoryViewController:
    BaseViewController<MedicalHistoryViewModel, MedicalHistoryPresenter, MedicalHistoryInteractor> {
	
	// MARK: - Outlets
    @IBOutlet private weak var vaccinesTable: UITableView!
    @IBOutlet private weak var reportsTable: UITableView!
    @IBOutlet private weak var documentsTable: UITableView!
    
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
