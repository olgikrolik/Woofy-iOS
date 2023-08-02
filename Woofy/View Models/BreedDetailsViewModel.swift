//
//  BreedDetailsViewModel.swift
//  Woofy
//
//  Created by Olga Królikowska on 23/07/2023.
//

import Foundation

struct BreedDetails {
    let designation: String
    let group: String
    let lifeSpan: String
    let temperament: [String]
    let weight: String
    let height: String
}

@MainActor
class BreedDetailsViewModel: ObservableObject {
    
    @Published var breedDetails: BreedDetails?
    @Published var showInternetConnectionError = false
    @Published var showGeneralError = false
    private let service = BreedsAPIService()
    
    func createTemperamentArray(temperamentString: String) -> [String] {
        let temperamentArray = temperamentString.components(separatedBy: ", ")
        return temperamentArray
    }
    
    func displayData(breedId: Int) {
        Task {
            do {
                let breed = try await service.getBreedById(id: breedId)
                let designation = breed.designation ?? "Unknown"
                let group = breed.group ?? "Unknown"
                let lifeSpan = breed.lifeSpan
                let temperament = createTemperamentArray(temperamentString: breed.temperament ?? "Unknown")
                let weight = breed.weight.weightInMetric
                let height = breed.height.heightInMetric
                breedDetails = BreedDetails(designation: designation, group: group, lifeSpan: lifeSpan, temperament: temperament, weight: weight, height: height)
            } catch BreedsAPIService.APIError.internetConnectionError {
                self.showInternetConnectionError = true
            } catch {
                self.showGeneralError = true
            }
        }
    }
}
