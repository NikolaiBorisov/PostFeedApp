//
//  GetPostsRequests.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 29.05.2021.
//

import Foundation

struct GetPostsRequest: NetworkRequest {
  
  typealias Response = PostDTO
  
  var path: String = ""
  let cursor: String?
  
  init(cursor: String? = nil) {
    self.cursor = cursor
    
    if let cursor = cursor {
      self.path = "after=\(cursor)"
    }
  }
  
}
