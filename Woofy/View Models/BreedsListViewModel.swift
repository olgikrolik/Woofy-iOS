//
//  BreedsListViewModel.swift
//  Woofy
//
//  Created by Olga Królikowska on 02/07/2023.
//

import Foundation

@MainActor
class BreedsListViewModel: ObservableObject {
    
    @Published var breedsInfo: [BreedInfo] = []
    @Published var showInternetConnectionError = false
    @Published var showGeneralError = false
    
    private let service = BreedsAPIService()
    private var page = 0
    private let pageLimit = 20
    private var isSearching = false
    
    func loadFirstPage() {
        page = 0
        loadData()
    }
    
    private func loadNextpage() {
        page += 1
        loadData()
    }
    
    func didChangeSearchQuery(searchBreedTerm: String) {
        if !searchBreedTerm.isEmpty {
            searchByBreedName(breedName: searchBreedTerm)
        } else {
            breedsInfo.removeAll()
            isSearching = false
            loadFirstPage()
        }
    }
    
    func searchByBreedName(breedName: String) {
        Task {
            isSearching = !breedName.isEmpty
            await searchData(breedName: breedName)
        }
    }
    
    func doPaginationIfNeeded(lastVisibleBreed: BreedInfo) {
        if lastVisibleBreed == breedsInfo.last && !isSearching {
        loadNextpage()
        }
    }
    
    private func loadData() {
        Task {
            do {
                let breeds = try await service.getBreedsByPage(page: page, pageLimit: pageLimit)
                var breedsInfo: [BreedInfo] = []
                for breed in breeds {
                    let id = breed.id
                    let name = breed.name
                    let image = breed.imageUrl
                    breedsInfo.append(BreedInfo(id: id, name: name, image: image))
                }
                self.breedsInfo.append(contentsOf: breedsInfo)
            } catch BreedsAPIService.APIError.internetConnectionError {
                self.showInternetConnectionError = true
            } catch {
                self.showGeneralError = true
            }
        }
    }
    
    func searchData(breedName: String) async {
        do {
            let breeds = try await service.getBreedsByName(searchTerm: breedName)
            var breedsInfo: [BreedInfo] = []
            for breed in breeds {
                let id = breed.id
                let name = breed.name
                let imageUrl = breed.imageUrl
                breedsInfo.append(BreedInfo(id: id, name: name, image: imageUrl))
            }
            self.breedsInfo = breedsInfo
        } catch BreedsAPIService.APIError.internetConnectionError {
            self.showInternetConnectionError = true
        } catch {
            self.showGeneralError = true
        }
    }
}

extension BreedsListViewModel {
    struct BreedInfo: Identifiable, Equatable, Hashable {
        let id: Int
        let name: String
        let image: URL?
    }
}
