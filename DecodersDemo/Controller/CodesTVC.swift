//
//  CodesTVC.swift
//  DecodersDemo
//
//  Created by Varender Singh on 17/02/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class CodesTVC: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var code: UILabel!
    
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var upvote: UILabel!
    
    @IBOutlet weak var downVote: UILabel!
    @IBOutlet weak var labeltags: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func putDataInFields(code:Code) {
        self.code.text = code.code;
        self.name.text = code.user_name;
        
        if let noDownVotes = code.downvotes {
            self.downVote.text = "\(noDownVotes)"
        }
        if let noUpVotes = code.upvotes {
            self.upvote.text = "\(noUpVotes)"
        }
        
        if let comments = code.comments  {
            self.lblComments.text = "\(comments)";
        }
        
        do {
            if(code.user_image_url != nil)  {
                let data = try NSData.init(contentsOf: URL.init(string: code.user_image_url!)!) as Data
                self.imageProfile.image = UIImage.init(data: data)
            }
        }
        catch let error {
            print(error.localizedDescription)
        }
        
        if let array = code.tages {
            self.labeltags.text = array.componentsJoined(by:"  ");
        }
        self.imageProfile.layer.cornerRadius = (imageProfile.layer.frame.size.height)/2
        self.imageProfile.clipsToBounds = true
        
        
    }
    
    
}
