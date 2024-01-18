//
//  DetailView.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 18.01.2024.
//

import SwiftUI

struct DetailView: View {
    
    let character: Result
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: character.image)){ image in
                image.image?.resizable()
            }
            
            .aspectRatio(contentMode: .fit)
            .frame(width: 200)
            
            Text(character.name)
            Text(character.species.rawValue)
            Text(character.status.rawValue)
        }
    }
}

#Preview {
    DetailView(character: .init(id: 1, name: "Emine", status: Status(rawValue: "") ?? Status.alive, species: Species(rawValue: "") ?? Species.human, gender: Gender(rawValue: "") ?? Gender.male, image: "https://wallpapers.com/images/featured-full/rick-and-morty-8rc57d4ds44gqzau.jpg"))
}
