//
//  BreedsAPIService.swift
//  Woofy
//
//  Created by Olga Królikowska on 02/07/2023.
//

import Foundation

class BreedsAPIService {
    
    private let baseUrl = "https://api.thedogapi.com"
    
    func addPlusBetweenWords(searchBreedTerm: String) -> String {
        let breedWithPlusBetweenWords = searchBreedTerm.replacingOccurrences(of: " ", with: "+")
        
        return breedWithPlusBetweenWords
    }
    
    func getBreedsByName(searchTerm: String) async throws -> [Breed] {
        let searchTerm = addPlusBetweenWords(searchBreedTerm: searchTerm)
        let endpoint = "\(baseUrl)/v1/breeds/search?q=\(searchTerm)"
        return try await getBreeds(endpoint: endpoint)
    }
    
    func getBreedsByPage(page: Int, pageLimit: Int) async throws -> [Breed] {
        let endpoint = "\(baseUrl)/v1/breeds?page=\(page)&limit=\(pageLimit)"
        return try await getBreeds(endpoint: endpoint)
    }
    
    func getBreedById(id: Int) async throws -> Breed {  //sprawdzić generic func czy tutaj można użyć
        let endpoint = "\(baseUrl)/v1/breeds/\(id)"
        
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw APIError.invalidResponse
            }
            
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(Breed.self, from: data)
            } catch {
                print(error)
                throw APIError.invalidData
            }
        } catch {
            if let err = error as? URLError, err.code == URLError.notConnectedToInternet {
                throw APIError.internetConnectionError
            } else {
                throw APIError.generalError
            }
        }
    }
    
    private func getBreeds(endpoint: String) async throws -> [Breed] {

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
                return try decoder.decode([Breed].self, from: data)
            } catch {
                print(error)
                throw APIError.invalidData
            }
        } catch {
            if let err = error as? URLError, err.code == URLError.notConnectedToInternet {   // gdy chcę obsłużyć dokładny status code errora albo response to muszę użyć castowania (as?), żeby wskazać o jaki rodzaj błędu mi chodzi
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

}
