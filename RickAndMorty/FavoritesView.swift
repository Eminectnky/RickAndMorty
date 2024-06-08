//
//  FavoritesView.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 31.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var service: RickAndMortyService
    @State private var isShowingAlert = false
    @State private var characterToDelete: FavoriteCharacter?
    
    var body: some View {
        NavigationView {
            List{
                ForEach(service.favoriteCharacters, id: \.id) { favoriteCharacter in
                    HStack{
                        if let imageUrlString = favoriteCharacter.image, let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure:
                                    Image(systemName: "exclamationmark.icloud.fill")
                                        .foregroundColor(.red)
                                @unknown default:
                                    ProgressView()
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        } else {
                            
                            Image(systemName: "exclamationmark.icloud.fill")
                                .foregroundColor(.red)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(favoriteCharacter.name ?? "")
                                .font(.headline)
                            
                            Text("Species: \(favoriteCharacter.species ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            
                            Text("Status: \(favoriteCharacter.status ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                }
                .onDelete(perform: delete)
            }
            
            .navigationTitle("Favorite Characters")
        }
        
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Alert"),
                message: Text("\(characterToDelete?.name ?? "") isimli karakteri favorilerden kaldırmak istediğinize emin misiniz?"),
                primaryButton: .destructive(Text("Delete")) {
                    if let characterToDelete = characterToDelete {
                        service.removeFavoriteCharacter(characterToDelete)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            characterToDelete = service.favoriteCharacters[index]
            isShowingAlert = true
            
        }
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RickAndMortyService())
    }
}
