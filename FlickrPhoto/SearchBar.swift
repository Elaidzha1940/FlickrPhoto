//  /*
//
//  Project: FlickrPhoto
//  File: SearchBar.swift
//  Created by: Elaidzha Shchukin
//  Date: 29.11.2023
//
//  */

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        
        HStack {
            TextField("Search...", text: $text, onCommit: {
                onSearch()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            Button(action: {
                onSearch()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.blue)
            }
            .padding(.trailing)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), onSearch: {})
            .previewLayout(.sizeThatFits)
    }
}
