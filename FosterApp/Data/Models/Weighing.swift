//
//  Weight.swift
//  FosterApp
//
//  Created by Elora on 28/02/2023.
//

import Foundation
import UIKit

struct Weighing: Equatable {
	
	var date: Date?
	var kittenWeight: String?
	var mealWeight: String?
	var id: String?
	
	init(from coreDataObject: DB_Weighing) {
		self.date = coreDataObject.a_date
		self.kittenWeight = coreDataObject.a_kittenWeight
		self.mealWeight = coreDataObject.a_mealWeight
		self.id = coreDataObject.a_id
	}
	
	init(id: String?, date: Date, kittenWeight: String, mealWeight: String) {
		self.date = date
		self.kittenWeight = kittenWeight
		self.mealWeight = mealWeight
		self.id = id
	}
}

class WeighingCell: BaseCell<Weighing> {
	
	//	override var item: Weighing? {
	//		didSet {
	//			textLabel?.text = item?.kittenWeight
	//		}
	//	}
	
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
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setupUI()
	}
	
	private func setupUI() {

		contentView.addSubview(dateLabel)
		contentView.addSubview(kittenWeightLabel)
		contentView.addSubview( milkWeightLabel)
		
		NSLayoutConstraint.activate([
			dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			kittenWeightLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 16),
			kittenWeightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			milkWeightLabel.leadingAnchor.constraint(equalTo: kittenWeightLabel.trailingAnchor, constant: 16),
			milkWeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			milkWeightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var item: Weighing? {
		didSet {
			dateLabel.text = item?.date?.toString()
			kittenWeightLabel.text = "\(item?.kittenWeight ?? "/")g"
			milkWeightLabel.text = "\(item?.mealWeight ?? "/")g"
		}
	}
}
