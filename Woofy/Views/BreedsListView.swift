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
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)
                GeometryReader { reader in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(breedsListViewModel.breedsInfo, id: \.id) { breed in
                                AsyncImage(url: breed.image) { image in
                                    ZStack (alignment: .bottom) {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: ((reader.size.width / 2) - 16), height: ((reader.size.width / 2) - 16) * 4/3 )
                                            .cornerRadius(5)
                                        ZStack (alignment: .center) {
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(height: 50)
                                                .foregroundStyle(.ultraThinMaterial)
                                                .opacity(0.9)
                                            Text(breed.name)
                                                .font(.custom("Trocchi-Regular", size: 14))
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                } placeholder: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: ((reader.size.width / 2) - 16), height: ((reader.size.width / 2) - 16) * 4/3 )
                                            .foregroundColor(.white.opacity(0.5))
                                        ProgressView()
                                    }
                                }
                                .onAppear {
                                    breedsListViewModel.doPaginationIfNeeded(lastVisibleBreed: breed)
                                }
                            }
                        }
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                    }
                }
                
                .navigationBarTitle("Breeds", displayMode: .large)
            }
            .alert(isPresented: $breedsListViewModel.showInternetConnectionError) {
                Alert(title: Text("Internet Connection Error"), message: Text("Please check your internet connection or try again later."), dismissButton: .default(Text("OK")))
            }
        }
        .searchable(text: $searchText, prompt: "Type a breed")
        .onChange(of: searchText) { value in
            breedsListViewModel.searchByBreedName(breedName: value)
        }
        .onAppear{
            breedsListViewModel.loadFirstPage()
        }
        .alert(isPresented: $breedsListViewModel.showGeneralError) {
            Alert(title: Text("Error"), message: Text("Oops! Something went wrong."), dismissButton: .default(Text("OK")))
        }
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
