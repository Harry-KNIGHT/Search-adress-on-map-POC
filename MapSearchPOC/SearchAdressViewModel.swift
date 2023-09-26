//
//  SearchAdressViewModel.swift
//  MapSearchPOC
//
//  Created by Elliot Knight on 23/09/2023.
//

import Combine
import Foundation
import MapKit
import SwiftUI

final class SearchAdressViewModel: ObservableObject {

	// MARK: Map & Marker position

	@Published public var mapCamera: MapCameraPosition = .camera(
		.init(centerCoordinate: .init(latitude: 48.854300, longitude: 2.383340), distance: 1000)
	)

	@Published public var mapMarkerPosition = CLLocationCoordinate2D(latitude: 48.854300, longitude: 2.383340)

	// MARK: User query for search adress

	@Published public var userQuery: String = ""
	private var cancellables = Set<AnyCancellable>()

	// MARK: Geocoder for query conversion to coordinates

	private let geocoder = CLGeocoder()

	init() {
		configureCancellables()
	}

	// MARK: Methods

	// Method for search when user has finish to write
	private func configureCancellables() {
		$userQuery
			.debounce(for: .seconds(1), scheduler: DispatchQueue.main)
			.sink { query in
				self.convertQueryIntoCoordinate(query: query)
			}
			.store(in: &cancellables)
	}

	private func convertQueryIntoCoordinate(query: String) {
		geocoder.geocodeAddressString(query) { placemark, error in
			guard let placemark = placemark?.first,
				  let latitude = placemark.location?.coordinate.latitude,
				  let longitude = placemark.location?.coordinate.longitude
			else { return }
			
			let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

			withAnimation {
				self.mapCamera = .camera(.init(centerCoordinate: coordinates, distance: 1000))
				self.mapMarkerPosition = .init(latitude: latitude, longitude: longitude)
			}
		}
	}
}
