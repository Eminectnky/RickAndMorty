//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 30.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filteredCharacters = [Result]()
    @State private var searchTxt = ""
    @StateObject private var service = RickAndMortyService()
    
    private var characters: [Result]{
        if searchTxt.isEmpty {
            return service.characters
        } else {
            return service.characters.filter { character in
                character.name.lowercased().contains(searchTxt.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView{
                VStack(spacing: 0) {
                    SearchBar(searchTxt: $searchTxt)
                    .padding(.bottom, 5)
                            List(characters, id: \.id) { character in
                                    NavigationLink(destination: DetailView(character: character)) {
                                        HStack {
                                            AsyncImage(url: URL(string: character.image)) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 100, height: 100)
                                                    .clipped()
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 100, height: 100)
                                            }
                                            VStack(alignment: .leading) {
                                                Text(character.name)
                                                Text(character.species.rawValue)
                                                Text(character.status.rawValue)
                                            }
                                        }
                                    }
                                }
                    
    //                         .listStyle(PlainListStyle())
                               .navigationTitle("Rick And Morty")
                               .onAppear {
                                    service.fetchCharacters { charactersData in
                                        self.service.characters = charactersData.results
                                    }
                               }
                }
            
        }
        
    }
}
    

#Preview {
  ContentView()
}
