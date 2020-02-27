//
//  NewsRequest.swift
//  NewsReader
//
//  Created by viacheslav.maiatckii on 15/02/2020.
//  Copyright © 2020 viacheslav.maiatckii. All rights reserved.
//

import Foundation

enum NewsError: Error {
    case noDataAvailable
    case canNotProcessData
}

let API_KEY = "64822bc097414f9f95177b464020a318" // Your API key is: 64822bc097414f9f95177b464020a318

struct TopHeadlinesRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://newsapi.org/v2/top-headlines?language=en&apiKey=\(API_KEY)"
//        let resourceString = "https://newsapi.org/v2/top-headlines?category=general&apiKey=\(API_KEY)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
    }
    
    func getTopHeadlines(completion: @escaping(Result<[Article], NewsError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {
            data, _, _ in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            print(jsonData)
            
            do {
                let decoder = JSONDecoder()
                let topHeadlinesResponse = try decoder.decode(TopHeadlinesResponse.self, from: jsonData)
                
                let status = topHeadlinesResponse.status
                if status == "ok" {
                    let articles = topHeadlinesResponse.articles
                    completion(.success(articles!))
                } else {
                    completion(.failure(.noDataAvailable))
                }
            } catch let error {
                print(error)
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
}

struct SourcesRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://newsapi.org/v2/sources?apiKey=\(API_KEY)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
    }
    
    func getSources(completion: @escaping(Result<[Source], NewsError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {
            data, _, _ in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let sourcesResponse = try decoder.decode(SourceResponse.self, from: jsonData)
                let sourcesDetails = sourcesResponse.sources
                completion(.success(sourcesDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
