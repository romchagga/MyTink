//
//  News.swift
//  MyTink
//
//  Created by macbook on 03.02.2023.
//

import Foundation

struct Envelope: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [News]
}

struct News: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}


