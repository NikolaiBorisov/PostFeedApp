//
//  ViewControllerModel.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 28.05.2021.
//

import Foundation

class ViewControllerModel {
  
  var items: [PostDTO.Data.Item] = []
  var cursor: String?
  var sortCursor: String?
  
  func getPosts(closure: @escaping () -> Void) {
    let request = GetPostsRequest(cursor: cursor)
    NetworkManager.shared.request(request: request) { [weak self] completion in
      switch completion {
      case .failure(let error): print(error)
      case .success(let result):
        self?.cursor = result.data.cursor
        self?.items.append(contentsOf: result.data.items)
        closure()
      }
    }
  }
  
  func getPosts(by sort: OrderType, closure: @escaping () -> Void) {
    let request = SortedNetworkRequest(type: sort, cursor: sortCursor)
    NetworkManager.shared.request(request: request) { [weak self] completion in
      switch completion {
      case .failure(let error): print(error)
      case .success(let result):
        self?.sortCursor = result.data.cursor
        self?.items.append(contentsOf: result.data.items)
        closure()
      }
    }
  }
  
}
