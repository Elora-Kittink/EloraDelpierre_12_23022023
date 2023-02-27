//
//  CLLocationCoordinate2D+Map.swift
//  CoreDataUtilsKit
//
//  Created by David Douard on 08/02/2021.
//

import Foundation
import MapKit

@available(iOSApplicationExtension, introduced: 1.0, unavailable)
extension CLLocationCoordinate2D {

/** Display an action sheet proposing to launch external Navigation application (Waze, Google Map, Map) and building itinary
     don't forget to add this autorization in the PLIST file of your project ;
     <key>LSApplicationQueriesSchemes</key>
     <array>
         <string>googlechromes</string>
         <string>comgooglemaps</string>
         <string>waze</string>
     </array>
     */

    public func openInMap() {
		
		let appleURL = URL(string: "http://maps.apple.com/?daddr=\(self.latitude),\(self.longitude)")
		let googleURL = URL(string: "comgooglemaps://?daddr=\(self.latitude),\(self.longitude)&directionsmode=driving")
		let wazeURL = URL(string: "waze://?ll=\(self.latitude),\(self.longitude)&navigate=false")
		
		let items: [(String, URL)] = [
			("Google Map", googleURL),
			("Waze", wazeURL),
			("Apple Maps", appleURL)
		]
			.compactMap { item in
				guard let url = item.1, UIApplication.shared.canOpenURL(url) else { return nil }
				return (item.0, url)
			}
		
		if items.count == 1, let url = items.first?.1 {
			url.open()
			return
		}
		
		var actions = items.map { item in
			AlertAction(title: item.0, style: .default) {
				item.1.open()
			}
		}
		
		actions.append(AlertAction(title: NSLocalizedString("cancel", comment: "Annuler"),
								   style: .cancel,
								   completion: nil))
		
		AlertManager.shared.show(actions: actions,
								 title: NSLocalizedString("TITLE_SELECT_NAVIGATION_APP", comment: "Selection"),
								 message: NSLocalizedString("MESSAGE_SELECT_NAVIGATION_APP", comment: "Selectionner une application"),
								 preferredStyle: .actionSheet)
    }
}
