//  LitterViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit

class LitterViewController: BaseViewController<LitterViewModel,LitterPresenter,LitterInteractor> {
	
	// MARK: - Outlets
	
    @IBOutlet weak var litterTable: UITableView!
    @IBOutlet weak var addKittenButton: AddButton!
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
