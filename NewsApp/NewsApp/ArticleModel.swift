//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Montana Braswell on 12/26/23.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate: ArticleModelProtocol?
    
    func getArticles() {
        
        // Fire off the request to the API
        
        // Create a string URL
        let stringURL = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=9eb01d85fe7d49f48169358380997304"
        
        // Create a URL object
        let url = URL(string: stringURL)
        
        // Check that it isn't nil
        guard let url = url else {
            print("Not valid link")
            return
        }

        // Get URL Session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            // Check that there are no errors and that there is data
            
            // error exists, error != nil
            
//            guard data != nil && error == nil else {
//                print("Cant find data and errors")
//                return
//            }
            
            if error == nil, let data = data {
            
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    // Parse the Json into ArticleService
                    
                    let articleService = try decoder.decode(ArticleService.self, from: data)
                    
                    // Get the articles
                    if  let articles = articleService.articles {
                        
                        // Pass it back to the view controller in the main thread
                        DispatchQueue.main.async {
                            self.delegate?.articlesRetrieved(articles)
                        }
                       
                        
                    } else {
                        print("Cannot find articles")
                        return
                    }
            
                }
                catch {
                    print("Error parsing the json")
                } // End Do - Catch
                
            } // End If
            
        } // End Data Task
        
        // Start the data task
        dataTask.resume()
    }
}
