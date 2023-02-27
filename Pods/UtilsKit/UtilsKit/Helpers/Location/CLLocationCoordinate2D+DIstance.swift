//
//  CLLocationCoordinate2D+DIstance.swift
//  UtilsKit
//
//  Created by Michael Coqueret on 17/01/2022.
//  Copyright © 2022 RGMC. All rights reserved.
//

import CoreLocation
import MapKit

public enum LocationError: Error {
	case notFound
}

extension CLLocationCoordinate2D {
	
	/// Get distance to `coordinate`
	public func getDistance(from coordinate: CLLocationCoordinate2D?) throws -> CLLocationDistance {
		guard let coordinate = coordinate else { throw LocationError.notFound }
		
		return CLLocation(latitude: self.latitude,
						  longitude: self.longitude)
			.distance(from: CLLocation(latitude: coordinate.latitude,
									   longitude: coordinate.longitude))
	}
	
	/// Get duration to `coordinate` with `allowedUnits` in `unitStyle`
	@available(iOS 13.0.0, *)
	public func getDuration(from coordinate: CLLocationCoordinate2D?,
							allowedUnits: NSCalendar.Unit = [.day, .hour, .minute],
							unitStyle: DateComponentsFormatter.UnitsStyle = .abbreviated) async throws -> String {
		guard let coordinate = coordinate else { throw LocationError.notFound }
		
		let source = MKPlacemark(coordinate: coordinate)
		let destination = MKPlacemark(coordinate: self)
		
		let request = MKDirections.Request()
		request.source = MKMapItem(placemark: source)
		request.destination = MKMapItem(placemark: destination)
		request.transportType = MKDirectionsTransportType.automobile
		request.requestsAlternateRoutes = true
		
		return try await withCheckedThrowingContinuation { continuation in
			MKDirections(request: request).calculate { response, _ in
				guard let route = response?.routes.first else {
					continuation.resume(throwing: LocationError.notFound)
					return
				}
				
				let duration = route.expectedTravelTime.toDuration(allowedUnits: allowedUnits,
																   unitStyle: unitStyle)
				continuation.resume(returning: duration)
			}
		}
	}
}
