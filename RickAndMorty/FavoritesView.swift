//
//  FavoritesView.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 31.05.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var service: RickAndMortyService 

    var body: some View {
        NavigationView {
            List(service.favoriteCharacters, id: \.id) { favoriteCharacter in
                VStack(alignment: .leading, spacing: 8) {
                    AsyncImage(url: URL(string: favoriteCharacter.image ?? "")) { phase in
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

                    Text(favoriteCharacter.name ?? "")
                        .font(.headline)

                    Text("Species: \(favoriteCharacter.species ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Status: \(favoriteCharacter.status ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Favorite Characters")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RickAndMortyService())
    }
}
