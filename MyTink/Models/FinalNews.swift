//
//  FinalNews.swift
//  MyTink
//
//  Created by macbook on 04.02.2023.
//

import Foundation

struct FinalNews {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var views = 0
    
    init(news: News) {
        self.author = news.author
        self.title = news.title
        self.description = news.description
        self.url = news.url
        self.urlToImage = news.urlToImage
        self.publishedAt = news.publishedAt
    }
}
