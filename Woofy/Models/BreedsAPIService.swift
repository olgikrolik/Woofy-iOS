//
//  BreedsAPIService.swift
//  Woofy
//
//  Created by Olga Królikowska on 02/07/2023.
//

import Foundation

class BreedsAPIService {
    
    func getBreeds() async throws -> [Breed] {
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
