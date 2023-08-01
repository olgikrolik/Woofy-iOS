//
//  BreedDetailsData.swift
//  Woofy
//
//  Created by Olga Królikowska on 29/06/2023.
//

import Foundation

struct Breed: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let designation: String?
    let group: String?
    let lifeSpan: String
    let temperament: String?
    let origin: String?
    let image: BreedImage?
    let weight: Weight
    let height: Height
    let referenceImageId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case designation = "bred_for"
        case group = "breed_group"
        case lifeSpan = "life_span"
        case temperament = "temperament"
        case origin = "origin"
        case image = "image"
        case weight = "weight"
        case height = "height"
        case referenceImageId = "reference_image_id"
    }

}


struct BreedImage: Codable, Hashable {
    let imageUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
}

struct Weight: Codable, Hashable {
    let weightInMetric: String
    
    enum CodingKeys: String, CodingKey {
        case weightInMetric = "metric"
    }
}

struct Height: Codable, Hashable {
    let heightInMetric: String
    
    enum CodingKeys: String, CodingKey {
        case heightInMetric = "metric"
    }
}
