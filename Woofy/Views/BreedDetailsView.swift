//
//  BreedDetailsView.swift
//  Woofy
//
//  Created by Olga Królikowska on 17/07/2023.
//

import SwiftUI
import WrappingHStack

struct BreedDetailsView: View {
    
    @ObservedObject var breedDetailsViewModel: BreedDetailsViewModel
    let breedTitleHeight: CGFloat = 114
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let breedDetails = breedDetailsViewModel.breedDetails {
                    let imageWidth = UIScreen.main.bounds.size.width
                    let imageHeight = imageWidth * 5/6
                    let horizontalPadding: CGFloat = 24
                    
                    ZStack(alignment: .bottom) {
                        breedImage(imageWidth: imageWidth, imageHeight: imageHeight)
                        breedIntroduction(horizontalPadding: horizontalPadding, breed: breedDetails)
                    }
                    .frame(height: imageHeight + CGFloat((breedTitleHeight * 1/2)), alignment: .top)
                    
                    sectionWithImage(horizontalPadding: horizontalPadding, title: "About breed")
                    
                    HStack {
                        breedDetailsTile(title: "Weight", value: breedDetails.weight)
                        breedDetailsTile(title: "Height", value: breedDetails.height)
                        breedDetailsTile(title: "Life span", value: breedDetails.lifeSpan)
                    }
                    .padding(.horizontal, horizontalPadding + 8)
                    .padding(.top, 15)
                    
                    sectionWithImage(horizontalPadding: horizontalPadding, title: "Temperament")
                    temperamentalFeatures(temperament: breedDetails.temperament, horizontalPadding: horizontalPadding)
                    
                    Spacer()
                } else {
                    ProgressView()
                }
                
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            breedDetailsViewModel.onViewAppear()
        }
    }
    
    func breedImage(imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
        AsyncImage(url: breedDetailsViewModel.imageUrl) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
                .frame(width: imageWidth, height: imageHeight)
                .clipped()
        } placeholder: {
            Image("WoofyDefaultImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
                .frame(width: imageWidth, height: imageHeight)
        }
    }
    
    func breedIntroduction(horizontalPadding: CGFloat, breed: BreedDetails) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundStyle(.ultraThinMaterial)
                .shadow(radius: 20)
                .opacity(0.9)
                .frame(height: breedTitleHeight)
                .padding(.horizontal, horizontalPadding)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(breedDetailsViewModel.breedName)
                        .font(.custom("Trocchi-Regular", size: 20))
                    Text(mergeDefinitionAndDescription(definition: "Group:  ", description: breed.group))
                        .font(.custom("Trocchi-Regular", size: 15))
                        .opacity(0.7)
                        .lineLimit(nil)
                    Text(mergeDefinitionAndDescription(definition: "Special skill: ", description: breed.designation))
                        .font(.custom("Trocchi-Regular", size: 15))
                        .opacity(0.7)
                        .lineLimit(nil)
                }
                
                Spacer()
                
                Button(action: {
                    breedDetailsViewModel.onHeartTapped()
                }, label: {
                    Image(systemName: breedDetailsViewModel.heartIconSystemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundColor(breedDetailsViewModel.heartColor)
                })
                .padding(.horizontal, horizontalPadding)
            }
            .padding(.horizontal, horizontalPadding + 20)
            .frame(height: CGFloat(breedTitleHeight), alignment: .leading)
        }
        .offset(y: CGFloat(breedTitleHeight * 1/2))
    }
    
    func mergeDefinitionAndDescription(definition: String, description: String) -> AttributedString {
        let definitionAttributedString = AttributedString(definition)
        let descriptionAttributedString = AttributedString(description)
        
        return definitionAttributedString + descriptionAttributedString
    }
    
    func sectionWithImage(horizontalPadding: CGFloat, title: String) -> some View {
        HStack {
            Image("WoofySmallIcon")
                .resizable()
                .frame(width: 30, height: 45)
            Text(title)
                .font(.custom("Trocchi-Regular", size: 15))
                .padding(.leading, 10)
            Spacer()
        }
        .padding(.horizontal, horizontalPadding + 8)
        .padding(.top, 15)
    }
    
    func breedDetailsTile(title: String, value: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("BackgroundColor"))
                .frame(height: 100)
            VStack {
                Text(title)
                    .font(.custom("Trocchi-Regular", size: 15))
                Text(value)
                    .font(.custom("Trocchi-Regular", size: 15))
                    .foregroundColor(Color("DetailsColor"))
                    .padding(.top, 1)
            }
        }
    }
    
    func temperamentalFeatures(temperament: [String], horizontalPadding: CGFloat) -> some View {
        return WrappingHStack(temperament, id:\.self, alignment: .center) { temperament in
            Text(temperament)
                .font(.custom("Trocchi-Regular", size: 15))
                .padding(.all, 8)
                .opacity(0.7)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color("DetailsColor"), lineWidth: 1)
                )
                .padding(3)
        }
        .padding(.horizontal, horizontalPadding + 8)
        .padding(.top, 8)
    }
    
}

//
//struct BreedDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreedDetailsView(imageUrl: URL(string: "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")!, id: <#T##UUID#>)
//    }
//}
