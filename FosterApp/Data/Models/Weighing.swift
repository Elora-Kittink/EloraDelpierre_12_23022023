//
//  Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import UIKit

/// A UITableViewCell subclass representing a weighing record.
class WeighingCell: BaseCell<Weighing> {
	
	// UI components for the cell
	private let dateLabel: UILabel! = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let kittenWeightLabel: UILabel! = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
		
	}()
	private let milkWeightLabel: UILabel! = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	/// Initializes a new `WeighingCell`.
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setupUI()
	}
	
	/// Sets up the UI components within the cell.
	private func setupUI() {
		contentView.addSubview(dateLabel)
		contentView.addSubview(kittenWeightLabel)
		contentView.addSubview( milkWeightLabel)
		
		// Constraints for layout
		NSLayoutConstraint.activate([
			dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			kittenWeightLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 16),
			kittenWeightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			milkWeightLabel.leadingAnchor.constraint(equalTo: kittenWeightLabel.trailingAnchor, constant: 16),
			milkWeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			milkWeightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])}
	
	/// Required initializer using a coder, marked as unavailable.
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Updates the cell when a new `Weighing` item is set.
	override var item: Weighing? {
		didSet {
			dateLabel.text = item?.date?.toString()
			kittenWeightLabel.text = "\(item?.kittenWeight ?? "/")g"
			milkWeightLabel.text = "\(item?.mealWeight ?? "/")g"
		}
	}
}

// Model structure for a weighing record.
struct Weighing: Equatable {
	
	var date: Date?
	var kittenWeight: String?
	var mealWeight: String?
	var id: String?
	
	/// Initializes a new `Weighing` instance from a CoreData `DB_Weighing` object.
	/// - Parameter coreDataObject: The `DB_Weighing` instance to convert.
	init(from coreDataObject: DB_Weighing) {
		self.date = coreDataObject.a_date
		self.kittenWeight = coreDataObject.a_kittenWeight
		self.mealWeight = coreDataObject.a_mealWeight
		self.id = coreDataObject.a_id
	}
	
	/// Initializes a new `Weighing` instance from form data.
	/// - Parameters:
	///   - id: Unique identifier for the weighing record.
	///   - date: Date of the weighing.
	///   - kittenWeight: Weight of the kitten.
	///   - mealWeight: Weight of the meal.
	init(id: String?, date: Date, kittenWeight: String, mealWeight: String) {
		self.date = date
		self.kittenWeight = kittenWeight
		self.mealWeight = mealWeight
		self.id = id
	}
}
