//
//  FavouriteBreed.swift
//  Woofy
//
//  Created by Olga Królikowska on 09/08/2023.
//

import Foundation

struct FavouriteBreed: Codable, Equatable {
    let id: Int
    let imageUrl: URL
    let breedName: String
}
