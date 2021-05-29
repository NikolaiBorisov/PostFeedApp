//
//  NetworkRequest+ Ext.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 27.05.2021.
//

import Foundation

extension NetworkRequest {
  
  func tryToBuildUrlRequest() -> URLRequest? {
    
    var components = URLComponents()
    components.scheme = Constants.API.scheme
    components.host = Constants.API.host
    components.path = Constants.API.path
    
    var queryItems: [URLQueryItem] = []
    queryItems.append(contentsOf: self.queryItems)
    components.queryItems = queryItems
    
    guard let url = components.url else { return nil }
    
    var request = URLRequest(url: url)
    request.timeoutInterval = Constants.TimeConstants.requestTimeoutInterval
    
    return request
  }
  
}

fileprivate extension NetworkRequest {
  
  var queryItems: [URLQueryItem] {
    var queryItems = [URLQueryItem]()
    if self.path != "", self.path.components(separatedBy: "&").count > 0 {
      self.path.components(separatedBy: "&").forEach {
        let queryComponents = $0.components(separatedBy: "=")
        queryItems.append(.init(name: queryComponents[0], value: queryComponents[1]))
      }
    }
    return queryItems
  }
  
}

extension NetworkRequest where Response == [String : Any] {
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response {
    guard !data.isEmpty else { return [:] }
    guard let response = try JSONSerialization.jsonObject(with: data, options: []) as? Response else {
      throw PostFeedError.somethingWrongWithUrlRequest
    }
    return response
  }
}

extension NetworkRequest where Response: Decodable {
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response {
    return try decoder.decode(Response.self, from: data)
  }
  
}
