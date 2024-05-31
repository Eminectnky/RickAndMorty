//
//  SearchBar.swift
//  RickAndMorty
//
//  Created by Emine CETINKAYA on 30.05.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchTxt: String
    @State private var filteredCharacters: [Result] = []
    
var body: some View {
        HStack{
                TextField("Search...", text: $searchTxt)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if !searchTxt.isEmpty {
                                Button(action: {
                                    self.searchTxt = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 20)
            }
        }
    
}
#Preview {
    SearchBar(searchTxt: .constant(""))
}
