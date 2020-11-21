//
//  APIHandler.swift
//  IVNews
//
//  Created by Mac HD on 18/11/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}

class APIService {

    static let shared = APIService()
    
    private let baseAPIURL = "https://newsapi.org/v2/"
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
        
    private init() {}
    
    private func executeDataTaskAndDecode<D: Decodable>(with urlString: String, completion: @escaping (Result<D, APIError>) -> ()) {
        executeDataTask(with: urlString, headers: [:]) { (result) in
            switch result {
            case .success(let data):
                do {
                    let model = try self.jsonDecoder.decode(D.self, from: data)
                    completion(.success(model))
                } catch let error as NSError{
                    print(error.localizedDescription)
                    completion(.failure(.invalidSerialization))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func executeDataTaskAndConvertToImage(with urlString: String, completion: @escaping (Result<UIImage, APIError>) -> ()) {
        executeDataTask(with: urlString, headers: [:], addAuthorisation: false) { (result) in
            switch result {
            case .success(let data):
                if let downloadedImage = UIImage(data: data) {
                    completion(.success(downloadedImage))
                } else {
                    completion(.failure(.noData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func executeDataTask(with urlString: String, headers: [String: String], addAuthorisation: Bool = true, completion: @escaping (Result<Data, APIError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.addValue(key, forHTTPHeaderField: value)
        }
        
        if addAuthorisation {
            request.addValue("610af74cdc25471d988bbeb8ca4f75cf", forHTTPHeaderField: "x-api-key")
        }
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error as NSError)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completion(.failure(.badHTTPResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
protocol NewsService {
    /// Gets the list of articles from API
    /// - Parameter completion: On completion either Error or List of Article is provided
    func getNews(completion: @escaping (Result<[Article], APIError>) -> ())
    
    
    /// Gets the image from API
    /// - Parameters:
    ///   - urlString: image url to be downloaded
    ///   - completion: On completion either Error or List of Article is provided
    func getImage(urlString: String, completion: @escaping (Result<UIImage, APIError>) -> ())
}
extension APIService: NewsService {
    func getNews(completion: @escaping (Result<[Article], APIError>) -> ()) {
        let url = "\(baseAPIURL)top-headlines?country=in&category=business"
        
        executeDataTaskAndDecode(with: url) { (result: Result<NewsResponse, APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response.articles))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getImage(urlString: String, completion: @escaping (Result<UIImage, APIError>) -> ()) {
        executeDataTaskAndConvertToImage(with: urlString, completion: completion)
    }
}

