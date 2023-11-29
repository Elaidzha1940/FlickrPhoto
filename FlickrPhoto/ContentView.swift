//  /*
//
//  Project: FlickrPhoto
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 29.11.2023
//
//  */

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var photos: [FlickrPhoto] = []
    @State private var selectedPhoto: FlickrPhoto? = nil
    @State private var isFullScreen = false

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearch: searchPhotos)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(photos, id: \.id) { photo in
                            PhotoItem(photo: photo)
                                .onTapGesture {
                                    selectedPhoto = photo
                                    isFullScreen.toggle()
                                }
                        }
                    }
                    .fullScreenCover(isPresented: $isFullScreen) {
                        if let selectedPhoto = selectedPhoto {
                            FullScreenPhotoView(photo: selectedPhoto)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Flickr Gallery")
        }
    }

    func searchPhotos() {
        // Implement Flickr API request here
        // You need to replace "your-api-key" with your actual API key
        let flickrAPI = FlickrAPI(apiKey: "your-api-key")
        flickrAPI.searchPhotos(query: searchText) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
            case .failure(let error):
                print("Error searching photos: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

