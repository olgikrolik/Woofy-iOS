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
    let temperament: String
    let weight: String
    let height: String
}

@MainActor
class BreedDetailsViewModel: ObservableObject {
    
    @Published var breedDetails: BreedDetails?
//    = BreedDetails(designation: "", group: "", lifeSpan: "", temperament: "", weight: "", height: "") //zastanowić się czy chcę przekazywać puste dane, czy lepiej jako optional całe BreedDetails? i unwrappować je w View
    @Published var showInternetConnectionError = false
    @Published var showGeneralError = false
    private let service = BreedsAPIService()
    
    func displayData(breedId: Int) {
        Task {
            do {
                let breed = try await service.getBreedById(id: breedId)
                let designation = breed.designation ?? "Unknown"
                let group = breed.group ?? "Unknown"
                let lifeSpan = breed.lifeSpan
                let temperament = breed.temperament ?? "Unknown"
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
