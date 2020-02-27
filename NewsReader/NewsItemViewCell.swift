//
//  NewsItemViewCell.swift
//  NewsReader
//
//  Created by viacheslav.maiatckii on 17/02/2020.
//  Copyright © 2020 viacheslav.maiatckii. All rights reserved.
//

import UIKit

class NewsItemViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var source: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
