//  MedicalHistoryViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UIKit

class MedicalHistoryViewController:
    BaseViewController<MedicalHistoryViewModel,MedicalHistoryPresenter,MedicalHistoryInteractor> {
	
	// MARK: - Outlets
    @IBOutlet weak var vaccinesTable: UITableView!
    @IBOutlet weak var reportsTable: UITableView!
    @IBOutlet weak var documentsTable: UITableView!
    
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
