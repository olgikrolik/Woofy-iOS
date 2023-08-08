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
    private let imageUrl: URL
    private let id: Int
    private let breedName: String
    
    init(imageUrl: URL, id: Int, breedName: String) {
        self.imageUrl = imageUrl
        self.id = id
        self.breedName = breedName
    }
    
    func createTemperamentArray(temperamentString: String) -> [String] {
        let temperamentArray = temperamentString.components(separatedBy: ", ")
        return temperamentArray
    }
    
    func displayData() {
        Task {
            do {
                let breed = try await service.getBreedById(id: id)
                let designation = breed.designation ?? "Unknown"
                let group = breed.group ?? "Unknown"
                let lifeSpan = breed.lifeSpan
                let temperament = createTemperamentArray(temperamentString: breed.temperament ?? "Unknown")
                let weight = "\(breed.weight.weightInMetric) kg"
                let height = "\(breed.height.heightInMetric) cm"
                breedDetails = BreedDetails(designation: designation, group: group, lifeSpan: lifeSpan, temperament: temperament, weight: weight, height: height)
            } catch BreedsAPIService.APIError.internetConnectionError {
                self.showInternetConnectionError = true
            } catch {
                self.showGeneralError = true
            }
        }
    }
    
    func onHeartTapped(isLiked: Bool) -> String {
        if isLiked == true {
            return "heart.fill"
        } else {
            return "heart"
        }
    }
}
