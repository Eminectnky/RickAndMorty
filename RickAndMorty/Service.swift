
//
//  Service.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 30.05.2024.
//

import Foundation

class RickAndMortyService: ObservableObject {
    
    @Published var characters: [Result] = []
    
    func fetchCharacters(completion: @escaping (Character) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Character.self, from: data) {
                    DispatchQueue.main.async {
                        self.characters = decodedResponse.results
                        completion(decodedResponse)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
