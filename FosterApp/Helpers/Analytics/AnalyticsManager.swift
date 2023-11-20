//
//  AnalyticsManager.swift
//  FosterApp
//
//  Created by Elora on 17/11/2023.
//

import Foundation
import FirebaseAnalytics
import UtilsKit

class AnalyticsManager {
	private init() { }
	
	static let shared = AnalyticsManager()
	 
	func log(event: AnalyticsEventTypes, with parameters: [String: String] = [:]) {
		Analytics.logEvent(event.rawValue,
						   parameters: parameters)
//		TODO: créér un log dans ce style
		print("\(event.rawValue) - \(parameters.values)")
	}
}

enum AnalyticsEventTypes: String {
	
	case userCreated = "tag_event_user_created"
	case userFetched = "tag_event_user_fetched"
	case kittenCreated = "tag_event_kitten_created"
	case kittenFetched = "tag_event_kitten_fetched"
	case litterCreated = "tag_event_litter_created"
	case litterFetched = "tag_event_litter_fetched"
	case weighingCreated = "tag_event_weighing_created"
	case pageOpen = "tag_page"
	case buttonPressed = "tag_button"
	case tableViewCellPressed = "tag_table_view_cell"
	case collectionViewCellPressed = "tag_collection_view_cell"
}
