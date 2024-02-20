//
//  ArticleService.swift
//  NewsApp
//
//  Created by Montana Braswell on 12/26/23.
//

import Foundation

struct ArticleService: Decodable {
    
    var totalResults:Int?
    var articles: [Article]?
    
}
