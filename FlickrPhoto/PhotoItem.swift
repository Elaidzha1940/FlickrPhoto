//  /*
//
//  Project: FlickrPhoto
//  File: PhotoItem.swift
//  Created by: Elaidzha Shchukin
//  Date: 29.11.2023
//
//  */

import SwiftUI

struct PhotoItem: View {
    let photo: FlickrPhoto
    
    var body: some View {
        AsyncImage(url: URL(string: photo.url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .cornerRadius(10)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .cornerRadius(10)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct PhotoItem_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItem(photo: FlickrPhoto(url: "https://example.com/your-image.jpg"))
            .previewLayout(.sizeThatFits)
    }
}
