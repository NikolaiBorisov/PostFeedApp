//
//  Posts.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 27.05.2021.
//

import Foundation

struct PostDTO: Decodable {
  
  var data: Data
  
  struct Data: Decodable {
    let items: [Item]
    let cursor: String?
    
    struct Item: Decodable {
      @DateValue var createdAt: String
      let id: String
      let author: Author
      let contents: [Content]?
      let stats: Statistics
      
      struct Author: Decodable {
        let name: String
        let photo: Photo?
        
        struct Photo: Decodable {
          let data: PhotoData
          
          struct PhotoData: Decodable {
            let extraSmall: ExtraSmall
            
            struct ExtraSmall: Decodable {
              let url: URL?
            }
          }
        }
      }
      struct Content: Decodable {
        var data: Value
        
        struct Value: Decodable {
          var value: String?
        }
      }
      struct Statistics: Decodable {
        let likes: LikesData
        let views: ViewsData
        let comments: CommentsData
        
        struct LikesData: Decodable {
          let count: Int?
        }
        struct ViewsData: Decodable {
          let count: Int?
        }
        struct CommentsData: Decodable {
          let count: Int?
        }
      }
    }
  }
  
}
