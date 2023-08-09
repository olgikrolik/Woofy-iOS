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
    
    func getFavouritesBreeds() -> [FavouriteBreed]?  {
        do {
            let decoder = JSONDecoder()
            if let favouritesBreedsData = userDefaults.data(forKey: favouritesKey) {
                var decodedFavouritesBreeds = try decoder.decode([FavouriteBreed].self, from: favouritesBreedsData)
                return decodedFavouritesBreeds
            }
            return nil
        } catch {
            print(error)
            return nil
        }
    }
    
    func saveFavouritesBreeds(favouritesBreedsArray: [FavouriteBreed]) {
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
            decodedFavouritesBreeds.removeAll { element in
                element == favouriteBreed
            }
            saveFavouritesBreeds(favouritesBreedsArray: decodedFavouritesBreeds)
        }
    }
}

    


