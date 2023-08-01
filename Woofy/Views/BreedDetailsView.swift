//
//  BreedDetailsView.swift
//  Woofy
//
//  Created by Olga Królikowska on 17/07/2023.
//

import SwiftUI
import WrappingHStack

struct BreedDetailsView: View {
    
    @ObservedObject var breedDetailsViewModel = BreedDetailsViewModel()
    
    let breedTitleHeight: CGFloat = 114
//    let temperamentArray = ["Stubborn", "Curious", "Playful", "Adventurous", "Active", "Fun-loving"]
    @State private var isLiked = false
    
    let imageUrl: URL
    let id: Int
    let breedName: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let breedDetails = breedDetailsViewModel.breedDetails {
                    let imageWidth = UIScreen.main.bounds.size.width
                    let imageHeight = imageWidth * 5/6
                    let horizontalPadding: CGFloat = 24
                    
                    ZStack(alignment: .bottom) {
                        breedImage(imageWidth: imageWidth, imageHeight: imageHeight)
                        backgroundForBreedIntroduction(horizontalPadding: horizontalPadding)
                        breedIntroduction(horizontalPadding: horizontalPadding, isLiked: isLiked, breed: breedDetails)
                    }
                    .frame(width: imageWidth, height: imageHeight + CGFloat((breedTitleHeight * 1/2)), alignment: .top)
                    
                    sectionWithImage(horizontalPadding: horizontalPadding, title: "About breed")
                    
                    HStack {
                        breedDetailsTile(title: "Weight", value: breedDetails.weight)
                        breedDetailsTile(title: "Height", value: breedDetails.height)
                        breedDetailsTile(title: "Life span", value: breedDetails.lifeSpan)
                    }
                    .padding(.horizontal, horizontalPadding + 8)
                    .padding(.top, 15)
                    
                    sectionWithImage(horizontalPadding: horizontalPadding, title: "Temperament")
                    temperamentalFeatures(temperament: breedDetails.temperament, horizontalPadding: horizontalPadding) //temperament String pomyśleć jak rozbić to w Array
                    
                    Spacer()
                } else {
                    ProgressView()
                }
                
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            breedDetailsViewModel.displayData(breedId: id)
        }
    }
    
    func breedImage(imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
        AsyncImage(url: imageUrl) { image in
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
    
    func backgroundForBreedIntroduction(horizontalPadding: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(.ultraThinMaterial)
            .shadow(radius: 20)
            .opacity(0.9)
            .frame(height: breedTitleHeight)
            .padding(.horizontal, horizontalPadding)
            .offset(y: CGFloat(breedTitleHeight * 1/2))
    }
    
    func breedIntroduction(horizontalPadding: CGFloat, isLiked: Bool, breed: BreedDetails) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(breedName)
                    .font(.custom("Trocchi-Regular", size: 20))
                Text(mergeDefinitionAndDescription(definition: "Group:  ", description: breed.group))
                    .font(.custom("Trocchi-Regular", size: 15))
                    .opacity(0.7)
                Text(mergeDefinitionAndDescription(definition: "Special skill: ", description: breed.designation))
                    .font(.custom("Trocchi-Regular", size: 15))
                    .opacity(0.7)
            }
            Button(action: {
                self.isLiked.toggle()
                
            }, label: {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .foregroundColor(isLiked  ? Color("DetailsColor") : .gray)
            })
            .padding(.horizontal, horizontalPadding)
        }
        .padding(.horizontal, horizontalPadding)
        .frame(height: CGFloat(breedTitleHeight), alignment: .leading)
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
    
    func createTemperamentArray(temperamentString: String) -> [String] {
        let temperamentArray = temperamentString.components(separatedBy: ", ")
        return temperamentArray
    }
    
    func temperamentalFeatures(temperament: String, horizontalPadding: CGFloat) -> some View {
        let temperamentFeaturesArray = createTemperamentArray(temperamentString: temperament)
        return WrappingHStack(temperamentFeaturesArray, id:\.self, alignment: .center) { temperament in
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
