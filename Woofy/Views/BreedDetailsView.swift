//
//  BreedDetailsView.swift
//  Woofy
//
//  Created by Olga Królikowska on 17/07/2023.
//

import SwiftUI

struct BreedDetailsView: View {
    let dogTitleHeight = 114
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                let imageHeight = reader.size.width * 5/6
                    AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")) { image in
                        ZStack(alignment: .bottom){
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(5)
                                .frame(width: reader.size.width, height: imageHeight)
                            RoundedRectangle(cornerRadius: 30)
                                .foregroundStyle(.ultraThinMaterial)
                                .shadow(radius: 0.5)
                                .opacity(0.9)
                                .frame(width: ((reader.size.width / 13) * 11), height: CGFloat( dogTitleHeight))
                                .offset(y: CGFloat(dogTitleHeight * 1/2))
                        }
                        .frame(height: imageHeight + CGFloat((dogTitleHeight * 1/2)), alignment: .top)
                    } placeholder: {
                        ProgressView()
                    }
            }
            Spacer()
        }
    }
}

struct BreedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailsView()
    }
}
