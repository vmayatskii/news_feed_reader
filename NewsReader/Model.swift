//
//  Model.swift
//  NewsReader
//
//  Created by viacheslav.maiatckii on 15/02/2020.
//  Copyright © 2020 viacheslav.maiatckii. All rights reserved.
//

import Foundation

struct SourceResponse: Codable {
    var status: String
    var sources: [Source]
}

struct Source: Codable {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
}

struct TopHeadlinesResponse: Codable {
    var status: String
    var code: String?
    var message: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct SourceShort: Codable {
    var id: String?
    var name: String?
}

struct Article: Codable {
    var source: SourceShort?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String? // TODO convert to dateTime
    var content: String?
}
