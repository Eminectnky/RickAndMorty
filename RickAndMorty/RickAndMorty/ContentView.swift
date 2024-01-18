//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 18.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var characters = [Result]()
    
    var body: some View {
        NavigationView{
            
            List(characters, id: \.id){ character in
                NavigationLink(destination: DetailView(character: character)){
                    HStack{
                        AsyncImage(url: URL(string: character.image)){ image in
                            image.image?.resizable()
                        }
                        .frame(width: 100, height: 100)
                        VStack(alignment: .leading)
                        {
                            Text(character.name)
                            Text(character.species.rawValue)
                            Text(character.status.rawValue)
                        }
                    }
                }
                
            }
                .navigationTitle("Rick And Morty")
                           
            .onAppear {
                RickAndMortyService().fetchCharacters {
                    charactersData in self.characters = charactersData.results
                }
                }
            }
    }
}

#Preview {
    ContentView()
}
