//
//  BreedDetailsData.swift
//  Woofy
//
//  Created by Olga Królikowska on 29/06/2023.
//

import Foundation

struct Breed: Codable, Identifiable {
    let id = UUID()
    let name: String
    let designation: String?
    let group: String?
    let lifeSpan: String
    let temperament: String?
    let origin: String?
    let image: Image
    let weight: Weight
    let height: Height
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case designation = "bred_for"
        case group = "breed_group"
        case lifeSpan = "life_span"
        case temperament = "temperament"
        case origin = "origin"
        case image = "image"
        case weight = "weight"
        case height = "height"
    }

}


struct Image: Codable {
    let imageUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
}

struct Weight: Codable {
    let weightInMetric: String
    
    enum CodingKeys: String, CodingKey {
        case weightInMetric = "metric"
    }
}

struct Height: Codable {
    let heightInMetric: String
    
    enum CodingKeys: String, CodingKey {
        case heightInMetric = "metric"
    }
}
