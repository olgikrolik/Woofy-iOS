//
//  FavouritesBreedsView.swift
//  Woofy
//
//  Created by Olga Królikowska on 07/08/2023.
//

import SwiftUI

struct FavouriteBreedsView: View {
    
    @ObservedObject var favouriteBreedsViewModel = FavouriteBreedsViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                GeometryReader { reader in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(favouriteBreedsViewModel.favouriteBreeds, id: \.id) { breed in
                                breedImageWithName(breed: breed, reader: reader)
                            }
                        }
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                    }
                }
                .navigationBarTitle("Favourites", displayMode: .large)
            }
        }
        .onAppear {
            favouriteBreedsViewModel.loadFavouriteBreeds()
        }
    }
    
    var backgroundColor: some View {
        Color("BackgroundColor")
            .edgesIgnoringSafeArea(.all)
    }
    
    func breedImageWithName(breed: FavouriteBreed, reader: GeometryProxy) -> some View {
        AsyncImage(url: breed.imageUrl) { image in
            ZStack (alignment: .bottom) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((reader.size.width / 2) - 16), height: ((reader.size.width / 2) - 16) * 4/3 )
                    .cornerRadius(5)
                ZStack (alignment: .center) {
                    breedNameFrame
                    breedName(breed: breed)
                }
            }
        } placeholder: {
            ZStack (alignment: .bottom) {
                Image("WoofyDefaultImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((reader.size.width / 2) - 16), height: ((reader.size.width / 2) - 16) * 4/3 )
                    .cornerRadius(5)
                ZStack (alignment: .center) {
                    breedNameFrame
                    breedName(breed: breed)
                }
            }
        }
    }
    
    var breedNameFrame: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(height: 50)
            .foregroundStyle(.ultraThinMaterial)
            .opacity(0.9)
    }
    
    func breedName(breed: FavouriteBreed) -> some View {
        Text(breed.breedName)
            .font(.custom("Trocchi-Regular", size: 14))
            .multilineTextAlignment(.center)
    }
    
}

struct FavouriteBreedsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteBreedsView()
    }
}
