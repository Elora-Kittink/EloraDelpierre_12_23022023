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
		
	}
}

enum AnalyticsEventTypes: String {
	
	case kittenCreated = "tag_event_kitten_created"
	case litterCreated = "tag_event_litter_created"
	case weighingCreated = "tag_event_weighing_created"
	case pageOpen = "tag_page"
	case buttonPressed = "tag_button"
}
