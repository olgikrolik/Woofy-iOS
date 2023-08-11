//
//  FavouriteBreedsViewModel.swift
//  Woofy
//
//  Created by Olga Królikowska on 11/08/2023.
//

import Foundation

class FavouriteBreedsViewModel: ObservableObject {
    
    @Published var favouriteBreeds: [FavouriteBreed] = []
    private let favouritesStore = FavouritesStore()
    
    func loadFavouriteBreeds() {
        favouriteBreeds = favouritesStore.getFavouriteBreeds() ?? []
    }
}
