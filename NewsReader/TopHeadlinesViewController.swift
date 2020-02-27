//
//  ExperimentalViewController.swift
//  NewsReader
//
//  Created by viacheslav.maiatckii on 17/02/2020.
//  Copyright © 2020 viacheslav.maiatckii. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    
    var listOfArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationTitle.title = "Loading..."
        tableView.isHidden = true
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        let request = TopHeadlinesRequest()
        request.getTopHeadlines { [weak self] result in
            self?.finishBackgroundActivityAsync()
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let articles):
                self?.listOfArticles = articles
                print(articles)
            }
        }
    }
    
    func finishBackgroundActivityAsync() {
        DispatchQueue.main.async {
            self.navigationTitle.title = "Top Headlines Feed"
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExperimentalNewsItemId", for: indexPath) as! NewsItemViewCell
        
        let article = listOfArticles[indexPath.row]
        
        cell.title?.text = article.title
        cell.date?.text = getReadableDate(article.publishedAt)
        cell.source?.text = article.source?.name
        return cell

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailsNavigationController
        {
            let vc = segue.destination as? DetailsNavigationController
            
            let indexPath = tableView.indexPathForSelectedRow
            
            guard let index = indexPath?.row else {
                return
            }
            
            let article = listOfArticles[index]
            guard let destinationController = vc?.viewControllers[0] as? ViewController else {
                return
            }
            
            destinationController.article = article
        }
        
    }

}
