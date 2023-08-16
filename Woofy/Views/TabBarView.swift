//
//  TabView.swift
//  Woofy
//
//  Created by Olga Królikowska on 16/08/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            Group {
                BreedsListView()
                    .tabItem {
                        Label("All", systemImage: "pawprint.fill")
                    }
                
                FavouriteBreedsView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .accentColor(Color("DetailsColor"))
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
