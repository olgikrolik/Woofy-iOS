//
//  BreedDetailsViewModel.swift
//  Woofy
//
//  Created by Olga Królikowska on 23/07/2023.
//

import Foundation
import SwiftUI

struct BreedDetails {
    let designation: String
    let group: String
    let lifeSpan: String
    let temperament: [String]
    let weight: String
    let height: String
}

struct FavouritesBreeds {
    let breedId: Int
}

@MainActor
class BreedDetailsViewModel: ObservableObject {
    
    @Published var breedDetails: BreedDetails?
    @Published var showInternetConnectionError = false
    @Published var showGeneralError = false
    @Published var isLiked = false
    let imageUrl: URL
    let breedName: String
    private let id: Int
    private let service = BreedsAPIService()
    
    init(imageUrl: URL, id: Int, breedName: String) {
        self.imageUrl = imageUrl
        self.id = id
        self.breedName = breedName
    }
    
    func createTemperamentArray(temperamentString: String) -> [String] {
        let temperamentArray = temperamentString.components(separatedBy: ", ")
        return temperamentArray
    }
    
    func onViewAppear() {
        checkIfBreedIsLiked()
        loadBreedDetailsFromAPI()
    }
    
    func checkIfBreedIsLiked() {
        var existingArray = userDefaults.array(forKey: favouritesKey) as? [Int] ?? []
        
        if existingArray.contains(id) {
            isLiked = true
        } else {
            isLiked = false
        }
    }
    
    func loadBreedDetailsFromAPI() {
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
    
    var heartIconSystemName: String {
        if isLiked {
            return "heart.fill"
        } else {
            return "heart"
        }
    }
    
    var heartColor: Color {
        if isLiked {
            return Color("DetailsColor")
        } else {
            return .gray
        }
    }
    
    func onHeartTapped() {
        isLiked.toggle()
        if isLiked {
            addBreedToFavourites()
        }
    }
    
    private var favouritesKey = "FavouritesKey"
    private var userDefaults = UserDefaults.standard
    
    func addBreedToFavourites() {
        var existingArray = userDefaults.array(forKey: favouritesKey) as? [Int] ?? []
        existingArray.append(id)
        userDefaults.set(existingArray, forKey: favouritesKey)
        print(existingArray)
    }
}
