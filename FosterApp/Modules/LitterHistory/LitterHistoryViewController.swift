//  LitterHistoryViewController.swift
//
//  Created by Elora on 27/02/2023.
//
import UtilsKit
import UIKit

class LitterHistoryViewController: BaseViewController<LitterHistoryViewModel,
	 LitterHistoryPresenter, LitterHistoryInteractor> {
    
    
	
	// MARK: - Outlets
    @IBOutlet private weak var headerLabel: UILabel!
	@IBOutlet private weak var addLitterButton: UIButton!
	
	// MARK: - Variables
    var user: User!
//	TODO: comprendre tout ça
	lazy var  littersTableView: BaseTableView<LitterCell, Litter> = {
		let littersTableView =  BaseTableView <LitterCell, Litter>(didSelect: didSelect(item:at:))
	return littersTableView
	}() // homework, Why did we change it to lazy var and into a self executed closure?
    
    let emptyView: UIView = {
        let view = UIView()
        
        let label = UILabel()
        label.text = "Vous n'avez pas encore de portée !"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
	// MARK: - View life cycle
	override func viewDidLoad() {
		self.interactor.refresh(user: user)
		super.viewDidLoad()
		self.setupUI()
        self.title = self.viewModel.title
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.interactor.refresh(user: user)
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen,with: ["page": "\(Self.self)"])
	}
    
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		littersTableView.items = self.viewModel.litters ?? []
		littersTableView.reloadData()
        littersTableView.backgroundView = self.viewModel.litters?.isEmpty ?? true ? self.emptyView : nil
//        self.headerLabel.text = self.viewModel.headerText
	}
	
	func setupUI() {
		self.view.addSubview(littersTableView)
		littersTableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			littersTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
			littersTableView.bottomAnchor.constraint(equalTo: self.addLitterButton.topAnchor, constant: -48),
			littersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			littersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor )
		])
	}

	// MARK: - Actions
    @IBAction private func addLitter() {
		AnalyticsManager.shared.log(event: .buttonPressed, with: ["button_name":"add_litter"])
		
		let vc = LitterViewController.fromStoryboard { vc in
			vc.isCreateMode = true
			vc.isDisplayMode = false
			vc.isEditMode = false
			vc.user = self.user
		}
        navigationController?.pushViewController(vc, animated: true)
    }
	
	func didSelect(item: Litter, at indexPath: IndexPath) {
		AnalyticsManager.shared.log(event: .tableViewCellPressed, with: ["cell_name":"\(item.rescueDate)"])
		
		let vc = LitterViewController.fromStoryboard { vc in
			vc.user = self.user
			vc.litterId = item.id
			vc.isDisplayMode = true
			vc.isCreateMode = false
			vc.isEditMode = false
		}
		navigationController?.pushViewController(vc, animated: true)
	}
}


//extension LitterHistoryViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        min(tableView.frame.height / 1.5, 50)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let litters = self.viewModel.litters else {
//            return 0
//        }
//       return litters.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "litterCell", for: indexPath)
//        self.interactor.refreshCell(litter: self.viewModel.litters?[indexPath.row])
//        cell.textLabel?.text = self.viewModel.kittenList
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let litterId = self.viewModel.litters?[indexPath.row].id else {
//            return
//        }
//		let vc = LitterViewController.fromStoryboard { vc in
//			vc.user = self.user
//			vc.litterId = litterId
//			vc.isDisplayMode = true
//			vc.isCreateMode = false
//			vc.isEditMode = false
//		}
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}

extension LitterHistoryViewController: StoryboardProtocol {
    static var storyboardName: String {
        "LitterHistory"
    }
    
    static var identifier: String? {
        "LitterHistoryViewController"
    }
}
