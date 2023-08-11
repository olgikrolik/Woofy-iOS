//
//  FavouritesAPIService.swift
//  Woofy
//
//  Created by Olga Królikowska on 07/08/2023.
//

import Foundation

class FavouritesStore {
    
    private var favouritesKey = "FavouritesKey"
    private var userDefaults = UserDefaults.standard
    
    private func getFavouritesBreeds() -> [FavouriteBreed]?  {
        do {
            let decoder = JSONDecoder()
            if let favouritesBreedsData = userDefaults.data(forKey: favouritesKey) {
                let decodedFavouritesBreeds = try decoder.decode([FavouriteBreed].self, from: favouritesBreedsData)
                return decodedFavouritesBreeds
            }
            return nil
        } catch {
            print(error)
            return nil
        }
    }
    
    private func saveFavouritesBreeds(favouritesBreedsArray: [FavouriteBreed]) {
        do {
            let encoder = JSONEncoder()
            let encodedFavouritesBreedsData = try encoder.encode(favouritesBreedsArray)
            userDefaults.set(encodedFavouritesBreedsData, forKey: favouritesKey)
        } catch {
            print(error)
        }
    }
    
    func addBreedToFavourites(favouriteBreed: FavouriteBreed) {
        if var decodedFavouritesBreeds = getFavouritesBreeds() {
            decodedFavouritesBreeds.append(favouriteBreed)
            saveFavouritesBreeds(favouritesBreedsArray: decodedFavouritesBreeds)
        } else {
            let favouritesBreeds: [FavouriteBreed] = [favouriteBreed]
            saveFavouritesBreeds(favouritesBreedsArray: favouritesBreeds)
        }
    }
    
    func removeBreedFromFavourites(favouriteBreed: FavouriteBreed) {
        if var decodedFavouritesBreeds = getFavouritesBreeds() {
            decodedFavouritesBreeds.removeAll { $0 == favouriteBreed }
            saveFavouritesBreeds(favouritesBreedsArray: decodedFavouritesBreeds)
        }
    }
    
    func checkIfBreedIsLiked(breedId: Int) -> Bool {
        if let decodedFavouritesBreeds = getFavouritesBreeds() {
            if decodedFavouritesBreeds.map({ $0.id }).contains(breedId) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

    


