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
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        layoutSubviews()
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = article.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        // Download and display the image
        
        
        // Check that the article actually has an image
        guard let urlString = article.urlToImage else {
            print("Could not find string")
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check the cachemanager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // There is image data, set the imageview and return
            articleImageView.image = UIImage(data: imageData)
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            return
        }
        
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
            
                // Save the data into cahce
                CacheManager.saveData(urlString, data)
                
                // Check if the url string that the data task went off to download matches the article this cell is set to display
                
                if self.articleToDisplay!.urlToImage == urlString {
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
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
