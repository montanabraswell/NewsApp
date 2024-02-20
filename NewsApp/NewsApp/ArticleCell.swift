//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Montana Braswell on 2/5/24.
//

import UIKit

class ArticleCell: UITableViewCell {

    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        // Clean up the cell before displaying the next article
        articleImageView.image = nil
        headlineLabel.text = ""
        layoutSubviews()
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        
        // check how to not force unwra[
        headlineLabel.text = article.title
        
        // Download and display the image
        
        // Check that the article actually has an image
        // Create url string
        guard let urlString = article.urlToImage else {
            print("Could not find string")
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check that the url isn't nill
        //guard url != nil else
        
        guard let url = url else {
            print("Couldn't create url object")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url) { (data, response, error) in
           
            // Check that there were no errors
            // if error == nil && data != nil
            if error == nil, let data = data {
            
                // Check if the url string that the data task went off to download matches the article this cell is set to display
                
                if self.articleToDisplay!.urlToImage == urlString {
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data)
                    }
                }
            } // End if
            
        } // End data task
        
        // Kick off the datatask
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
