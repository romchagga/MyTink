//
//  NetworkManager.swift
//  MyTink
//
//  Created by macbook on 03.02.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping(Result<[News], NetworkError>) -> Void) {
        guard let url = URL(string:"https://newsapi.org/v2/top-headlines?country=ru&category=sport&apiKey=6457ff1fb8e64104ab6a3631f330fcdc") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            do {
                let envelope = try JSONDecoder().decode(Envelope.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(envelope.articles))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
