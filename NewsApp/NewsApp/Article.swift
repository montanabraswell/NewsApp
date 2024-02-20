//
//  Article.swift
//  NewsApp
//
//  Created by Montana Braswell on 12/26/23.
//

import Foundation

struct Article : Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
}
