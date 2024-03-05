//  HomeViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

/// `HomeViewController` manages the home screen of the application.
/// This controller inherits from `BaseViewController` and is specialized with `HomeViewModel`, 
/// `HomePresenter`, and `HomeInteractor` for its operation.
class HomeViewController: BaseViewController< HomeViewModel, HomePresenter, HomeInteractor> {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var welcomeLabel: UILabel!
	
	// MARK: - View life cycle
	
	/// Called after the controller's view is loaded into memory.
	override func viewDidLoad() {
		super.viewDidLoad()
	
		// Setting up the collection view's data source and delegate.
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		
		// Registering the cell class for the collection view.
		self.collectionView.register(Tile.self, forCellWithReuseIdentifier: "NewTile")

		// Ensuring the collection view's layout is properly configured.
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		// Checking if a user is currently connected.
		self.interactor.userIsConnected()
//		self.interactor.refresh()
		
		
		// Setting up an observer for the 'userLogged' notification.
		NotificationCenter.default.addObserver(forName: NSNotification.Name("userLogged"),
											   object: nil,
											   queue: nil) { _ in
		
			
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.scrollDirection = .vertical // ou .vertical selon vos besoins
			flowLayout.minimumLineSpacing = 10 // Espace entre les lignes
			flowLayout.minimumInteritemSpacing = 10 // Espace entre les cellules d'une ligne

			// Appliquez le UICollectionViewFlowLayout à votre UICollectionView
			self.collectionView.collectionViewLayout = flowLayout
			
			self.interactor.userIsConnected()
		}
	}
	/// Called when the view is about to be added to a view hierarchy.
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		AnalyticsManager.shared.log(event: .pageOpen, with: ["page": "\(Self.self)"])
	}
	
	// MARK: - Refresh
	/// Refreshes the UI with new data stored in the ViewModel.
	override func refreshUI() {
		super.refreshUI()
		self.welcomeLabel.text = "Bienvenu \(self.viewModel.user?.name ?? "")"
		self.collectionView.reloadData()
	}
}

// MARK: - Storyboard Protocol Conformance

extension HomeViewController: StoryboardProtocol {
	static var storyboardName: String {
		"Home"
	}
	
	static var identifier: String? {
		"HomeViewController"
	}
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout Conformance

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	// Implementation of collection view delegate methods.
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		AnalyticsManager.shared.log(event: .collectionViewCellPressed, 
									with: ["cell_name": "\(self.viewModel.homeTiles[safe: indexPath.row]?.title ?? "")"])
		
		guard let item = self.viewModel.homeTiles[safe: indexPath.row] else { return }
			guard let user = self.viewModel.user else { return }
			self.interactor.didSelectTile(tileType: item, user: user)
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let screenWidth = UIScreen.main.bounds.size.width
		let width = (screenWidth / 2) - 32
		
		return CGSize(width: width, height: width)
	}
}

// MARK: - UICollectionViewDataSource Conformance
extension HomeViewController: UICollectionViewDataSource {
	// Implementation of collection view data source methods.
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.viewModel.homeTiles.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let item = self.viewModel.homeTiles[safe: indexPath.row]

		else { return collectionView.dequeueEmptyCell(forIndexPath: indexPath) }
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTile", for: indexPath) as? Tile else {
			return collectionView.dequeueEmptyCell(forIndexPath: indexPath)
		}
				   
		cell.configure(image: item.image ?? UIImage(), text: item.title)
		cell.isAccessibilityElement = true
		cell.accessibilityTraits = .button
		cell.accessibilityValue = item.title
		
		return cell
	}
}
