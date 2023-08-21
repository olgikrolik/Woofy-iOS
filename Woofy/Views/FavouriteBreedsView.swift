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
                if favouriteBreedsViewModel.favouriteBreeds.isEmpty {
                    textForEmptyFavourites
                } else {
                    GeometryReader { reader in
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 2) {
                                ForEach(favouriteBreedsViewModel.favouriteBreeds, id: \.id) { breed in
                                    NavigationLink(value: breed) {
                                        breedImageWithName(breed: breed, reader: reader)
                                    }
                                }
                            }
                            .padding(.leading, 18)
                            .padding(.trailing, 18)
                        }
                    }
                    .navigationBarTitle("Favourites", displayMode: .large)
                }
            }
            .navigationDestination(for: FavouriteBreed.self) { breed in
                let viewModel = BreedDetailsViewModel(imageUrl: breed.imageUrl, id: breed.id, breedName: breed.breedName)
                BreedDetailsView(breedDetailsViewModel: viewModel)
            }
            .onAppear {
                favouriteBreedsViewModel.loadFavouriteBreeds()
            }
        }
        .accentColor(.black)
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
                
                Button(action: {
                    favouriteBreedsViewModel.onHeartTapped(id: breed.id)
                }, label: {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(radius: 5)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color("DetailsColor"))
                })
                .position(x: (reader.size.width / 2) - 40, y: 25)
                
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
    
    var textForEmptyFavourites: some View {
        Text("No breeds added to favourites")
            .font(.custom("Trocchi-Regular", size: 18))
            .multilineTextAlignment(.center)
            .foregroundColor(Color("DetailsColor"))
    }
}

struct FavouriteBreedsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteBreedsView()
    }
}
