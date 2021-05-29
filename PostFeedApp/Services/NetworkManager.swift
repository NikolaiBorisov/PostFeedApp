//
//  NetworkManager.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 27.05.2021.
//

import UIKit

enum PostFeedError: String, Error {
  case somethingWrongWithUrlRequest
  case somethingWrongWithUrlSessionData
}

class NetworkManager {
  
  static let shared = NetworkManager()
  private init() {}
  
  let cache = NSCache<NSString, UIImage>()
  
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  private lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.default
    return URLSession(configuration: configuration)
  }()
  
  func request<T: NetworkRequest>(request: T, closure: @escaping (Result<T.Response, Error>) -> Void) {
    guard let urlRequest = request.tryToBuildUrlRequest() else {
      closure(.failure(PostFeedError.somethingWrongWithUrlRequest))
      return
    }
    
    self.session
      .dataTask(with: urlRequest, completionHandler: { data, _, error in
        
        if let error = error {
          closure(.failure(error))
          return
        }
        
        guard let data = data else {
          closure(.failure(PostFeedError.somethingWrongWithUrlSessionData))
          return
        }
        do {
          let response = try request.decode(data: data, with: self.decoder)
          DispatchQueue.main.async {
            closure(.success(response))
          }
        } catch {
          closure(.failure(error))
        }
      })
      .resume()
  }
  
}
