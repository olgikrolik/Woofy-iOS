//
//  BreedsListView.swift
//  Woofy
//
//  Created by Olga Królikowska on 20/06/2023.
//

import SwiftUI

struct BreedsListView: View {
    
    @State private var searchText = ""
    let data = ["https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg",
                "https://cdn2.thedogapi.com/images/hMyT4CDXR.jpg",
                "https://cdn2.thedogapi.com/images/rkiByec47.jpg",
                "https://cdn2.thedogapi.com/images/1-7cgoZSh.jpg",
                "https://cdn2.thedogapi.com/images/26pHT3Qk7.jpg",
                "https://cdn2.thedogapi.com/images/BFRYBufpm.jpg",
                "https://cdn2.thedogapi.com/images/33mJ-V3RX.jpg",
                "https://cdn2.thedogapi.com/images/-HgpNnGXl.jpg"
    ]
//    let columns = [
////        GridItem(.fixed(203)),
////        GridItem(.flexible())
//        GridItem(.adaptive(minimum: 150), spacing: 2)
//    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    GeometryReader { reader in
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(data, id: \.self) { image in
                                AsyncImage(url: URL(string: image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: (reader.size.width / 2), height: (reader.size.width / 2) * 4/3 )
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: (reader.size.width / 2), height: (reader.size.width / 2) * 4/3 )
                                .border(.blue)
                            }
//                            .aspectRatio(contentMode: .fill)
                        }
                    }
                }
                .navigationBarTitle("Breeds")
                .padding()
            }
        .searchable(text: $searchText, prompt: "Type a breed")
    }
}

struct BreedsListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedsListView()
    }
}
