//
//  News.swift
//  MyTink
//
//  Created by macbook on 03.02.2023.
//

import Foundation
//
//protocol NetworkProtocol: Codable {
//    var author: String? {get set}
//    var title: String? {get set}
//    var description: String? {get set}
//    var url: String? {get set}
//    var urlToImage: String? {get set}
//    var publishedAt: String? {get set}
//}

struct Envelope: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [News]
}

class News: Decodable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
}


