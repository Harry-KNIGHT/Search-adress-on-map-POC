//
//  MapSearchPOCApp.swift
//  MapSearchPOC
//
//  Created by Elliot Knight on 23/09/2023.
//

import SwiftUI

@main
struct MapSearchPOCApp: App {
	@StateObject private var searchAdressViewModel = SearchAdressViewModel()
    var body: some Scene {
        WindowGroup {
			MapView()
				.environmentObject(searchAdressViewModel)
        }
    }
}
