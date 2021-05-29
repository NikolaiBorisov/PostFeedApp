//
//  NetworkRequest.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 27.05.2021.
//

import Foundation

protocol NetworkRequest {
  
  var path: String { get }
  
  associatedtype Response = [String : Any]
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response
}
