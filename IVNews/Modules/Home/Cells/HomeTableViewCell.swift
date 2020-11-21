//
//  HomeTableViewCell.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    /// Shows the image of article
    @IBOutlet weak var headerImage: UIImageView!
    
    /// Shows the title of article
    @IBOutlet weak var titleLbl: UILabel!
    
    /// shows the description of article
    @IBOutlet weak var descLbl: UILabel!
    
    /// shows the date of article
    @IBOutlet weak var dateLbl: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(article: Article) {
        if let imageURL = article.urlToImage {
            headerImage.imageFromServerUsing(urlString: imageURL, placeHolder: UIImage(named: "placeholder"))
        }
        titleLbl.text = article.title
        descLbl.text = article.description
        dateLbl.text = article.formattedDate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
