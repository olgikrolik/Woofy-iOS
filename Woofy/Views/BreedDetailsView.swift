//
//  BreedDetailsView.swift
//  Woofy
//
//  Created by Olga Królikowska on 17/07/2023.
//

import SwiftUI

struct BreedDetailsView: View {
    
    let breedTitleHeight = 114
    
    var body: some View {
        VStack(spacing: 0) {
            let imageWidth = UIScreen.main.bounds.size.width
            let imageHeight = imageWidth * 5/6
            let horizontalPadding: CGFloat = 24
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(5)
                            .frame(width: imageWidth, height: imageHeight)
                    } placeholder: {
                        Image("WoofyDefaultImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(5)
                            .frame(width: imageWidth, height: imageHeight)
                    }
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.ultraThinMaterial)
                        .shadow(radius: 20)
                        .opacity(0.9)
                        .frame(height: CGFloat(breedTitleHeight))
                        .padding(.horizontal, horizontalPadding)
                        .offset(y: CGFloat(breedTitleHeight * 1/2))
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Affenpinscher")
                                .font(.custom("Trocchi-Regular", size: 20))
                            Text("Group:")
                                .font(.custom("Trocchi-Regular", size: 15))
                                .opacity(0.7)
                            Text("Special skill:")
                                .font(.custom("Trocchi-Regular", size: 15))
                                .opacity(0.7)
                        }
                        .padding(.horizontal, horizontalPadding)
                        Spacer()
                    }
                    .padding(.horizontal, horizontalPadding)
                    .frame(height: CGFloat(breedTitleHeight), alignment: .leading)
                    .offset(y: CGFloat(breedTitleHeight * 1/2))
                }
                .frame(width: imageWidth, height: imageHeight + CGFloat((breedTitleHeight * 1/2)), alignment: .top)
            
            HStack {
                Image("WoofySmallIcon")
                    .resizable()
                    .frame(width: 30, height: 45)
                Text("About breed")
                    .font(.custom("Trocchi-Regular", size: 15))
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding + 8)
            .padding(.top, 15)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.accentColor)
                        .frame(height: 100)
                    VStack {
                        Text("Weight")
                            .font(.custom("Trocchi-Regular", size: 15))
                        Text("3-6 kg")
                            .font(.custom("Trocchi-Regular", size: 15))
                            .foregroundColor(Color("DetailsColor"))
                            .padding(.top, 1)
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.accentColor)
                        .frame(height: 100)
                    VStack {
                        Text("Height")
                            .font(.custom("Trocchi-Regular", size: 15))
                        Text("23-29 cm")
                            .font(.custom("Trocchi-Regular", size: 15))
                            .foregroundColor(Color("DetailsColor"))
                            .padding(.top, 1)
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.accentColor)
                        .frame(height: 100)
                    VStack {
                        Text("Life span")
                            .font(.custom("Trocchi-Regular", size: 15))
                        Text("10-12 yrs")
                            .font(.custom("Trocchi-Regular", size: 15))
                            .foregroundColor(Color("DetailsColor"))
                            .padding(.top, 1)
                    }
                }
            }
            .padding(.horizontal, horizontalPadding + 8)
            .padding(.top, 15)
            
            HStack {
                Image("WoofySmallIcon")
                    .resizable()
                    .frame(width: 30, height: 45)
                Text("Temperament")
                    .font(.custom("Trocchi-Regular", size: 15))
                    .padding(.leading, 10)
                Spacer()
            }
            .padding(.horizontal, horizontalPadding + 8)
            .padding(.top, 15)
            
            Spacer()
        }
    }
}

struct BreedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailsView()
    }
}
