//
//  BreedDetailsView.swift
//  Woofy
//
//  Created by Olga Królikowska on 17/07/2023.
//

import SwiftUI
import WrappingHStack

struct BreedDetailsView: View {
    
    let breedTitleHeight: CGFloat = 114
    let temperamentArray = ["Stubborn", "Curious", "Playful", "Adventurous", "Active", "Fun-loving"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                let imageWidth = UIScreen.main.bounds.size.width
                let imageHeight = imageWidth * 5/6
                let horizontalPadding: CGFloat = 24
                
                ZStack(alignment: .bottom) {
                    breedImage(imageWidth: imageWidth, imageHeight: imageHeight)
                    backgroundForBreedIntroduction(horizontalPadding: horizontalPadding)
                    breedIntroduction(horizontalPadding: horizontalPadding)
                }
                .frame(width: imageWidth, height: imageHeight + CGFloat((breedTitleHeight * 1/2)), alignment: .top)
                
                sectionWithImage(horizontalPadding: horizontalPadding, title: "About breed")
                
                HStack {
                    breedDetailsTile(title: "Weight", value: "3-6 kg")
                    breedDetailsTile(title: "Height", value: "23-29 cm")
                    breedDetailsTile(title: "Life span", value: "10-12 yrs")
                }
                .padding(.horizontal, horizontalPadding + 8)
                .padding(.top, 15)
                
                sectionWithImage(horizontalPadding: horizontalPadding, title: "Temperament")
                temperamentalFeatures(temperamentArray: temperamentArray, horizontalPadding: horizontalPadding)
                
                Spacer()
            }
        }
    }
    
    
    func breedImage(imageWidth: CGFloat, imageHeight: CGFloat) -> some View {
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
    
    func breedIntroduction(horizontalPadding: CGFloat) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Affenpinscher")
                    .font(.custom("Trocchi-Regular", size: 20))
                Text(mergeDefinitionAndDescription(definition: "Group:  ", description: "Toy"))
                    .font(.custom("Trocchi-Regular", size: 15))
                    .opacity(0.7)
                Text(mergeDefinitionAndDescription(definition: "Special skill: ", description: "Small rodent hunting, lapdog"))
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
    
    func mergeDefinitionAndDescription(definition: String, description: String) -> AttributedString {
        var definitionAttributedString = AttributedString(definition)
        var descriptionAttributedString = AttributedString(description)
        
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
                .foregroundColor(.accentColor)
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
    
    func temperamentalFeatures(temperamentArray: [String], horizontalPadding: CGFloat) -> some View {
        WrappingHStack(temperamentArray, id:\.self, alignment: .center) { temperament in
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


struct BreedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailsView()
    }
}
