//
//  ViewController.swift
//  NewsReader
//
//  Created by viacheslav.maiatckii on 14/02/2020.
//  Copyright © 2020 viacheslav.maiatckii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    
    var article = Article()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        articleTitle.text = article.title
        articleAuthor.text = article.author
        articleDate.text = getReadableDate(article.publishedAt)
        articleSource.text = article.source?.name
        articleDescription.text = article.description
    }

    @IBAction func closeDetails(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

