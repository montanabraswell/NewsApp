//
//  ViewController.swift
//  NewsApp
//
//  Created by Montana Braswell on 12/26/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view controller as the data source and delegate of the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        model.delegate = self
        model.getArticles()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get the article that the tableview is asking about
        let article = articles[indexPath.row]
        
        // Customimze it
        cell.displayArticle(article)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articlesRetrieved(_ articles: [Article]) {
        
        // Set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        // Refresh the tableview
        tableView.reloadData()
    }

}

