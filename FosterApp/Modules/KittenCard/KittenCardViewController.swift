//  KittenCardViewController.swift
//
//  Created by Elora on 24/02/2023.
//

import UIKit
import UtilsKit

class KittenCardViewController: BaseViewController<KittenCardViewModel, KittenCardPresenter, KittenCardInteractor> {
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var microshipLabel: UILabel!
    @IBOutlet private weak var weightHistory: UIView!
    @IBOutlet private weak var medicalHistory: UIView!
    @IBOutlet private weak var editBtn: UIButton!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var image: UIImageView!
    
//    TODO: faire un xib pour les brithdate/rescueDate/Color/Adopters
    
    // MARK: - Variables
    
    var litterId = ""
    var litter: Litter!
    var kitten: Kitten!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.refresh(kitten: self.kitten, litter: self.litter)
    }
    
    
    // MARK: - Refresh
    override func refreshUI() {
        super.refreshUI()
            
        self.editBtn.isHidden = self.viewModel.editBtnHidden
    }
    
    // MARK: - Actions
    
    @IBAction private func edit() {
        let vc = KittenCardModalViewController.fromStoryboard()
        vc.litter = self.litter
        vc.kitten = self.kitten
        vc.isCreatingMode = false
        vc.isEditingMode = true
        navigationController?.present(vc, animated: true)
    }
    
    @IBAction private func adopte() {
    }
}

extension KittenCardViewController: StoryboardProtocol {
    static var storyboardName: String {
        "KittenCard"
    }
    
    static var identifier: String? {
        "KittenCardViewController"
    }
}
