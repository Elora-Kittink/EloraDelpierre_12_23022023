//  HomeViewController.swift
//
//  Created by Elora on 27/02/2023.
//

import UtilsKit
import UIKit
import FirebaseCore
import FirebaseAuth

class HomeViewController: BaseViewController< HomeViewModel, HomePresenter, HomeInteractor> {
	
	// MARK: - Outlets
	
	@IBOutlet private weak var logOutbutton: UIButton!
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var welcomeLabel: UILabel!
	
	// MARK: - View life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		self.collectionView.dataSource = self
		self.collectionView.delegate = self
		self.collectionView.register(Tile.self, forCellWithReuseIdentifier: "NewTile")
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		self.interactor.userIsConnected()
		NotificationCenter.default.addObserver(forName: NSNotification.Name("userLogged"),
											   object: nil,
											   queue: nil) { [interactor] _ in
		
			
			let flowLayout = UICollectionViewFlowLayout()
			flowLayout.scrollDirection = .horizontal // ou .vertical selon vos besoins
			flowLayout.minimumLineSpacing = 10 // Espace entre les lignes
			flowLayout.minimumInteritemSpacing = 10 // Espace entre les cellules d'une ligne

			// Appliquez le UICollectionViewFlowLayout à votre UICollectionView
			self.collectionView.collectionViewLayout = flowLayout
			
			self.interactor.userIsConnected()
		}
	}
	//	TODO: quand LoginInteractor ou SignUpInteractor close() ça revient sur HomeViewCo,troller mais ça ne refresh pas donc on reste à l'état vide, il faudrait repasser dans le viewdidload
	//	essayer de passer une nottification dans la completion du close()
	// MARK: - Refresh
	override func refreshUI() {
		super.refreshUI()
		self.welcomeLabel.text = "Bienvenu \(self.viewModel.user?.name ?? "")"
		self.collectionView.reloadData()
	}
	
	// MARK: - Actions
	
	@IBAction private func logOut() {
		self.interactor.logOut()
	}
}

extension HomeViewController: StoryboardProtocol {
	static var storyboardName: String {
		"Home"
	}
	
	static var identifier: String? {
		"HomeViewController"
	}
}

// MARK: - UICollectionViewDelegate & UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.viewModel.homeTiles.count
	}
	
//	TODO: créer UIcollectionVIewCell custom avec image
//	Pour le didselectrowat renvoyer vers l'interactor en passant le user qui s'occupera de faire le switch sur les case
//	et de push les viewcontroller
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let item = self.viewModel.homeTiles[safe: indexPath.row]

		else { return collectionView.dequeueEmptyCell(forIndexPath: indexPath) }
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTile", for: indexPath) as? Tile else {
			return collectionView.dequeueEmptyCell(forIndexPath: indexPath)
		}
				   
		cell.configure(image: item.image ?? UIImage(), text: item.title)
				   
		return cell
	}
}
