//
//  BreedsListView.swift
//  Woofy
//
//  Created by Olga Królikowska on 20/06/2023.
//

import SwiftUI

struct BreedsListView: View {
    
    @ObservedObject var breedsListViewModel = BreedsListViewModel()
    @State private var searchText = ""
    
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
                            ForEach(breedsListViewModel.breedsInfo, id: \.id) { breed in
                                NavigationLink(value: breed) {
                                    breedImageWithName(breed: breed, reader: reader)
                                    .onAppear {
                                        breedsListViewModel.doPaginationIfNeeded(lastVisibleBreed: breed)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                    }
                }
                .navigationBarTitle("Breeds", displayMode: .large)
            }
            .navigationDestination(for: BreedsListViewModel.BreedInfo.self) { breed in
                if let imageUrl = breed.image {
                    let viewModel = BreedDetailsViewModel.init(imageUrl: imageUrl, id: breed.id, breedName: breed.name)
                    BreedDetailsView.init(breedDetailsViewModel: viewModel)
                }
            }
            .alert(isPresented: $breedsListViewModel.showInternetConnectionError) {
                Alert(title: Text("Internet Connection Error"), message: Text("Please check your internet connection or try again later."), dismissButton: .default(Text("OK")))
            }
        }
        .accentColor(.black)
        .searchable(text: $searchText, prompt: "Type a breed")
        .onChange(of: searchText) { value in
            breedsListViewModel.didChangeSearchQuery(searchBreedTerm: value)
        }
        .onAppear {
            breedsListViewModel.loadFirstPage()
        }
        .alert(isPresented: $breedsListViewModel.showGeneralError) {
            Alert(title: Text("Error"), message: Text("Oops! Something went wrong."), dismissButton: .default(Text("OK")))
        }
    }
    
    var backgroundColor: some View {
        Color("BackgroundColor")
            .edgesIgnoringSafeArea(.all)
    }
    
    func breedImageWithName(breed: BreedsListViewModel.BreedInfo, reader: GeometryProxy) -> some View {
        AsyncImage(url: breed.image) { image in
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
    
    func breedName(breed: BreedsListViewModel.BreedInfo) -> some View {
        Text(breed.name)
            .font(.custom("Trocchi-Regular", size: 14))
            .multilineTextAlignment(.center)
    }
    
    
    
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
