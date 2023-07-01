//
//  BreedDetailsData.swift
//  Woofy
//
//  Created by Olga Królikowska on 29/06/2023.
//

import Foundation

struct Breed: Codable {
    let name: String
    let designation: String
    let group: String
    let lifeSpan: String
    let temperament: String
    let origin: String
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
        case heightInMetric = "height"
    }
}

func getBreed() async throws -> Breed {
    let endpoint = "https://api.thedogapi.com/v1/breeds"
    
    guard let url = URL(string: endpoint) else {
        throw APIError.invalidURL
    }
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {   //przecinek między warunkami jest równoznaczny temu &&
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Breed.self, from: data)
        } catch {
            throw APIError.invalidData
        }
    } catch {
        if let err = error as? URLError, err.code == .notConnectedToInternet {   // gdy chcę obsłużyć dokładny status code errora albo response to muszę użyć castowania (as?), żeby wskazać o jaki rodzaj błędu mi chodzi
            throw APIError.internetConnectionError
        } else {
            throw APIError.generalError
        }
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case generalError
    case internetConnectionError
}

