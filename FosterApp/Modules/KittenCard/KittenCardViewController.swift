//  KittenCardViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit

class KittenCardViewController: BaseViewController<KittenCardViewModel,KittenCardPresenter,KittenCardInteractor> {
	
	// MARK: - Outlets
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var name2Field: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var birthdateField: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexField: UILabel!
    @IBOutlet weak var microshipLabel: UILabel!
    @IBOutlet weak var microshipField: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorField: UILabel!
    @IBOutlet weak var adoptersLabel: UILabel!
    @IBOutlet weak var adopterField: UILabel!
    @IBOutlet weak var siblingsLabel: UILabel!
    @IBOutlet weak var siblingsField: UILabel!
    @IBOutlet weak var rescueDateLabel: UILabel!
    @IBOutlet weak var rescueDateField: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var commentsField: UILabel!
    @IBOutlet weak var weighingButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var weightHistory: UIView!
    @IBOutlet weak var medicalHistory: UIView!

    
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
