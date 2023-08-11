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
    
    func getFavouriteBreeds() -> [FavouriteBreed]?  {
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
    
    private func saveFavouriteBreeds(favouritesBreedsArray: [FavouriteBreed]) {
        do {
            let encoder = JSONEncoder()
            let encodedFavouritesBreedsData = try encoder.encode(favouritesBreedsArray)
            userDefaults.set(encodedFavouritesBreedsData, forKey: favouritesKey)
        } catch {
            print(error)
        }
    }
    
    func addBreedToFavourites(favouriteBreed: FavouriteBreed) {
        if var decodedFavouritesBreeds = getFavouriteBreeds() {
            decodedFavouritesBreeds.append(favouriteBreed)
            saveFavouriteBreeds(favouritesBreedsArray: decodedFavouritesBreeds)
        } else {
            let favouritesBreeds: [FavouriteBreed] = [favouriteBreed]
            saveFavouriteBreeds(favouritesBreedsArray: favouritesBreeds)
        }
    }
    
    func removeBreedFromFavourites(favouriteBreed: FavouriteBreed) {
        if var decodedFavouritesBreeds = getFavouriteBreeds() {
            decodedFavouritesBreeds.removeAll { $0 == favouriteBreed }
            saveFavouriteBreeds(favouritesBreedsArray: decodedFavouritesBreeds)
        }
    }
    
    func checkIfBreedIsLiked(breedId: Int) -> Bool {
        if let decodedFavouritesBreeds = getFavouriteBreeds() {
            if decodedFavouritesBreeds.map({ $0.id }).contains(breedId) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

    


