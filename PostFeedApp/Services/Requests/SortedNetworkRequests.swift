//
//  SortedNetworkRequests.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 29.05.2021.
//

import Foundation

enum OrderType: String {
  case mostPopular
  case mostCommented
  case createdAt
}

struct SortedNetworkRequest: NetworkRequest {
  
  var path: String
  typealias Response = PostDTO
  
  init(type: OrderType, cursor: String?) {
    self.path = "orderBy=\(type.rawValue)"
    
    if let cursor = cursor {
      path += "&after=\(cursor)"
    }
  }
  
}
