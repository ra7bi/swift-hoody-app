//
//  PostsCell.swift
//  MyHood
//
//  Created by fahad alrahbi on 3/5/16.
//  Copyright © 2016 FahadCoder. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {

    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        postImg.layer.cornerRadius = 15.0
        postImg.clipsToBounds = true
        
    }

    
    // Check Post Class we already set a getter for title and post
    func configureCell(post:Post)
    {
        // Will call Passed Post class and give it some data . 
        titleLbl.text = post.title
        descLbl.text = post.postDesc
        postImg.image = DataService.instance.imageforPath(post.imagePath)
    }
}
