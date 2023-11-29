//  /*
//
//  Project: FlickrPhoto
//  File: FlickrAPI.swift
//  Created by: Elaidzha Shchukin
//  Date: 29.11.2023
//
//  */

import Foundation

struct FlickrPhoto: Identifiable {
    let id = UUID()
    let url: String
}

struct FlickrAPI {
    let apiKey: String

    func searchPhotos(query: String, completion: @escaping (Result<[FlickrPhoto], Error>) -> Void) {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(query)&format=json&nojsoncallback=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let result = try JSONDecoder().decode(FlickrSearchResponse.self, from: data!)
                let photos = result.photos.photo.map { photo in
                    FlickrPhoto(url: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")
                }
                completion(.success(photos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct FlickrSearchResponse: Decodable {
    let photos: FlickrPhotos
}

struct FlickrPhotos: Decodable {
    let photo: [FlickrPhotoInfo]
}

struct FlickrPhotoInfo: Decodable {
    let id: String
    let farm: Int
    let server: String
    let secret: String
}
