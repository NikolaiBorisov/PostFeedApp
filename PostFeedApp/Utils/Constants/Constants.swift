//
//  Constants.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 28.05.2021.
//

import UIKit

enum Constants {
  
  enum Image {
    static let avatarPlaceholder: UIImage? = UIImage(named: "photo")
  }
  
  enum CellConstants {
    static let contentTableViewCell: String = "ContentTableViewCell"
    static let cellRowHeight: CGFloat = 150.0
  }
  
  enum API {
    static let scheme = "https"
    static let host = "k8s-stage.apianon.ru"
    static let path = "/posts/v1/posts"
  }
  
  enum VCTitle {
    static let postVCTitle = "Post Feed"
  }
  
  enum NavigationItemTitle {
    static let rightItemTitle = "Filter"
  }
  
  enum LabelPlaceholder {
    static let loadingLabelText = "Loading Post Feed..."
    static let nameLabelPlaceholder = "Name: "
    static let dateLabelPlaceholder = "Date: "
    static let postLabelPlaceholder = "Post: "
    static let idLabelPlaceholder = "ID: "
    static let detailsLabelPlaceholder = "Post Details:"
    static let likesLabelPlaceholder = "❤️ "
    static let viewsLabelPlaceholder = "👀 "
    static let commentsLabelPlaceholder = "💬 "
    static let searchControllerPlaceholder = "Search the post by author id..."
  }
  
  enum TimeAndDateFormat {
    static let myDateFormatStyle = "yy MMM d, HH:mm"
    static let localeIdentifier = "ru_Ru"
  }
  
  enum TimeConstants {
    static let millisecondsInOneSecond: Double = 1_000
    static let requestTimeoutInterval: Double = 10.0
  }
  
  enum Loading {
    static let loadingCircleCornerRadius: CGFloat = 15.0
    static let animationTime: Double = 3.0
    static let animationDurationForCircle: Double = 0.6
    static let animationDelayForCircle: Double = 0.5
  }
  
  enum LoadingStackViewConstants {
    static let height: CGFloat = 30.0
    static let width: CGFloat = 100.0
    static let stackViewTopAnchor: CGFloat = 10.0
    static let stackViewSpacing: CGFloat = 5.0
  }
  
  enum FooterStackViewConstants {
    static let stackViewSpacing: CGFloat = 10.0
  }
  
  enum LabelStackViewConstants {
    static let stackViewSpacing: CGFloat = 5.0
  }
  
  enum AuthorAvatarConstants {
    static let avatarCornerRadius: CGFloat = 35.0
    static let avatarBorderWidth: CGFloat = 3.0
    static let avatarBorderColor = UIColor.lightGray.cgColor
  }
  
  enum DetailsAuthorAvatarConstants {
    static let avatarCornerRadius: CGFloat = 5.0
    static let avatarBorderWidth: CGFloat = 3.0
    static let avatarBorderColor = UIColor.systemOrange.cgColor
  }
  
  enum PostCellLayoutsConstants {
    static let avatarleadingAnchor: CGFloat = 20.0
    static let avatarWidth: CGFloat = 70.0
    static let avatarHeight: CGFloat = 70.0
    
    static let nameLabelTopAnchor: CGFloat = 10.0
    static let nameLabelLeadingAnchor: CGFloat = 10.0
    
    static let postLabelTopAnchor: CGFloat = 5.0
    static let postLabelLeadingAnchor: CGFloat = 10.0
    static let postLabelTrailingAnchor: CGFloat = -10.0
    
    static let dateLabelTopAnchor: CGFloat = 5.0
    static let dateLabelLeadingnAnchor: CGFloat = 10.0
    static let dateLabelBottomAnchor: CGFloat = -10.0
  }
  
  enum DetailsVCLayoutsConstants {
    static let detailsLabelTopAnchor: CGFloat = 10.0
    
    static let thumbnailImageViewTopAnchor: CGFloat = 10.0
    static let thumbnailImageViewWidthAnchor: CGFloat = 150.0
    static let thumbnailImageViewHeightAnchor: CGFloat = 150.0
    
    static let labelStackViewTopAnchor: CGFloat = 10
    
    static let footerStackViewTopAnchor: CGFloat = 20
  }
  
  enum DefaultValue {
    static let defaultPostText = "none"
  }
  
}
