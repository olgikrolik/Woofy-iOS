//
//  BreedsListViewModel.swift
//  Woofy
//
//  Created by Olga Królikowska on 02/07/2023.
//

import Foundation

struct BreedInfo: Identifiable, Equatable {
    let id: UUID
    let name: String
    let image: URL?
}

@MainActor
class BreedsListViewModel: ObservableObject {
    
    @Published var breedsInfo: [BreedInfo] = []
    @Published var showInternetConnectionError = false
    @Published var showGeneralError = false
    
    private let service = BreedsAPIService()
    private var page = 0
    private let pageLimit = 20
    
    func loadFirstPage() {
        page = 0
        loadData()
    }
    
    func loadNextpage() {
        page += 1
        loadData()
    }
    
    private func loadData() {
        Task {
            do {
                let breeds = try await service.getBreeds(page: page, pageLimit: pageLimit)
                var breedsInfo: [BreedInfo] = []
                for breed in breeds {
                    let id = breed.id
                    let name = breed.name
                    let image = breed.image.imageUrl
                    breedsInfo.append(BreedInfo(id: id, name: name, image: image))
                }
                self.breedsInfo.append(contentsOf: breedsInfo)
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

