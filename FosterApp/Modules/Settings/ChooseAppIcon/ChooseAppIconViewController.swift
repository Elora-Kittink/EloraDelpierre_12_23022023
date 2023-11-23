//  ChooseAppIconViewController.swift
//
//  Created by Elora on 21/11/2023.
//

import UtilsKit

class ChooseAppIconViewController: BaseViewController
<
	ChooseAppIconViewModel,
	ChooseAppIconPresenter,
	ChooseAppIconInteractor
> {
	
	// MARK: - Outlets
	
	// MARK: - Variables
	@IBOutlet private weak var tableView: UITableView!
	
	
	// MARK: - View life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "IconCell")

		tableView.delegate = self
		tableView.dataSource = self
		
		self.title = self.viewModel.title
	}
	
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
	}

	// MARK: - Actions
	
}

extension ChooseAppIconViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let iconName = self.viewModel.icons[indexPath.row]
		
		// Utilisez la classe UIApplication pour changer l'icône
		if UIApplication.shared.supportsAlternateIcons {
			UIApplication.shared.setAlternateIconName(iconName) { error in
				if let error = error {
					print("Changement de l'icône a échoué : \(error.localizedDescription)")
				} else {
					print("L'icône a été changée avec succès.")
				}
			}
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		150
	}
}

extension ChooseAppIconViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.viewModel.icons.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
		cell.imageView?.image = UIImage(named: self.viewModel.icons[indexPath.row])
		return cell
	}
}

extension ChooseAppIconViewController: StoryboardProtocol {
	static var storyboardName: String {
		"ChooseAppIcon"
	}
	
	static var identifier: String? {
		"ChooseAppIconViewController"
	}
}
