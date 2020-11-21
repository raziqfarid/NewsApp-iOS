//
//  Model.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import Foundation

struct NewsResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date
    let content: String?
    
    // Display Property
    var formattedDate: String? {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: publishedAt)
    }
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
