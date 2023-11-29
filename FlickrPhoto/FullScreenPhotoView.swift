//  /*
//
//  Project: FlickrPhoto
//  File: FullScreenPhotoView.swift
//  Created by: Elaidzha Shchukin
//  File: 29.11.2023
//
//  */

import SwiftUI

struct FullScreenPhotoView: View {
    let photo: FlickrPhoto
    
    var body: some View {
        
        AsyncImage(url: URL(string: photo.url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct FullScreenPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenPhotoView(photo: FlickrPhoto(url: "https://example.com/your-image.jpg"))
    }
}
