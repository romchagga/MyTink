//
//  CacheManager.swift
//  MyTink
//
//  Created by macbook on 04.02.2023.
//

import Foundation

class CacheManager {
    
    static let shared = CacheManager()
    
    private let defaults = UserDefaults.standard
    private let key = "newsList"
    
    
    func getNews()->[FinalNews]? {
        if let savedNews = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedNews = try? decoder.decode([FinalNews].self, from: savedNews) {
                return loadedNews
            }
        }
        return nil
    }
    
    func saveNews(news: [FinalNews]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(news) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
}
