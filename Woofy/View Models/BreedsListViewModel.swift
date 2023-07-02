//
//  BreedsListViewModel.swift
//  Woofy
//
//  Created by Olga Królikowska on 02/07/2023.
//

import Foundation

struct BreedInfo: Identifiable {
    let id: UUID
    let name: String
    let image: URL?
}

@MainActor
class BreedsListViewModel: ObservableObject {
    
    @Published var breedsInfo: [BreedInfo] = []
    @Published var showInternetConnectionError = false
    @Published var showGeneralError = false
    let service = BreedsAPIService()
    
    func onAppear() {
        Task {
            do {
                let breeds = try await service.getBreeds()
                var breedsInfo: [BreedInfo] = []
                for breed in breeds {
                    let id = breed.id
                    let name = breed.name
                    let image = breed.image.imageUrl
                    breedsInfo.append(BreedInfo(id: id, name: name, image: image))
                }
                self.breedsInfo = breedsInfo
            } catch BreedsAPIService.APIError.internetConnectionError {
                DispatchQueue.main.async {
                    self.showInternetConnectionError = true
                }
            } catch {
                DispatchQueue.main.async {
                    self.showGeneralError = true
                }
            }
        }
    }
}

