//  ChooseAppIconViewController.swift
//
//  Created by Elora on 21/11/2023.
//

import UtilsKit


/// `ChooseAppIconViewController` is a view controller responsible for displaying a list of app icons and handling user selection to change the app's icon.
/// This controller inherits from `BaseViewController` and is specialized with `ChooseAppIconViewModel`, `ChooseAppIconPresenter`, and `ChooseAppIconInteractor` for its operation.
class ChooseAppIconViewController: BaseViewController
<
	ChooseAppIconViewModel,
	ChooseAppIconPresenter,
	ChooseAppIconInteractor
> {
	
//	test build Bitrise
	
	// MARK: - Outlets
	
	/// The table view used to display available app icons.
	@IBOutlet private weak var tableView: UITableView!
	
	// MARK: - View life cycle
	

	/// Called after the controller's view is loaded into memory.
	/// Registers UITableViewCell for the table view, sets up delegates, and initializes the view's title.
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "IconCell")

		tableView.delegate = self
		tableView.dataSource = self
		
		self.title = self.viewModel.title
	}
}

extension ChooseAppIconViewController: UITableViewDelegate {
	
	/// Handles the selection of an app icon from the table view.
	/// Changes the app's icon if the feature is supported.
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

	/// Specifies the height for rows in the table view.
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		150
	}
}

extension ChooseAppIconViewController: UITableViewDataSource {
	
	/// Returns the number of rows in a given section of the table view.
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.viewModel.icons.count
	}
	
	/// Provides a cell to be inserted in a particular location of the table view.
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
		cell.imageView?.image = UIImage(named: self.viewModel.icons[indexPath.row])
		cell.isAccessibilityElement = true
		cell.accessibilityTraits = .button
		cell.accessibilityLabel = "icone chatons dans un carton n°\(indexPath.row)"
		return cell
	}
}

/// Extension conforming to `StoryboardProtocol` for storyboard-based instantiation.
extension ChooseAppIconViewController: StoryboardProtocol {
	static var storyboardName: String {
		"ChooseAppIcon"
	}
	
	static var identifier: String? {
		"ChooseAppIconViewController"
	}
}
