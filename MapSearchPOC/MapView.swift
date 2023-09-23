//
//  MapView.swift
//  MapSearchPOC
//
//  Created by Elliot Knight on 23/09/2023.
//

import SwiftUI
import MapKit

struct MapView: View {
	@EnvironmentObject private var searchViewModel: SearchAdressViewModel
    var body: some View {
		NavigationStack {
			VStack {
				Map(position: $searchViewModel.mapCamera) {
					Marker("Home", coordinate: searchViewModel.mapMarkerPosition)

				}.mapControls {
					MapScaleView()
				}
			}
			.searchable(
				text: $searchViewModel.userQuery,
				placement: .navigationBarDrawer(displayMode: .always)
			)
			.navigationTitle("Search your home !")
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

#Preview {
	MapView()
		.environmentObject(SearchAdressViewModel())
}
