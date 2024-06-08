
//
//  Service.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 30.05.2024.
//

import Foundation
import CoreData
import UserNotifications

class RickAndMortyService: ObservableObject {
    
    @Published var characters: [Result] = []
    @Published var favoriteCharacters: [FavoriteCharacter] = []
    
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    init() {
        fetchFavorites()
    }
    
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
    
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            favoriteCharacters = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch favorite characters: \(error.localizedDescription)")
        }
    }
    
    func toggleFavorite(character: Result) {
        if let favorite = favoriteCharacters.first(where: { $0.id == character.id }) {
            viewContext.delete(favorite)
            
        } else {
            let favorite = FavoriteCharacter(context: viewContext)
            favorite.id = Int64(character.id)
            favorite.name = character.name
            favorite.image = character.image
            favorite.isFavorite = true
        }
        saveContext()
        fetchFavorites()
    }
    
    func isFavorite(character: Result) -> Bool {
        return favoriteCharacters.contains(where: { $0.id == character.id })
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func removeFavoriteCharacter(_ character: FavoriteCharacter) {
        viewContext.delete(character)
        saveContext()
        fetchFavorites()
    }
    
    private func sendMaxFavoritesNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Limit Reached"
        content.body = "Favori karakter ekleme sayısını aştınız. Başka bir karakteri favorilerden çıkarmalısınız."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled")
            }
        }
    }
}


