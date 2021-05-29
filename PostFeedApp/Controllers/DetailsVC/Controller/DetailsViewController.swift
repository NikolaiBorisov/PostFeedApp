//
//  DetailsViewController.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 28.05.2021.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var post: PostDTO.Data.Item?
  
  let cache = NetworkManager.shared.cache
  
  lazy var detailsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.text = Constants.LabelPlaceholder.detailsLabelPlaceholder
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }()
  
  lazy var thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Constants.Image.avatarPlaceholder
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = Constants.DetailsAuthorAvatarConstants.avatarCornerRadius
    imageView.layer.borderWidth = Constants.DetailsAuthorAvatarConstants.avatarBorderWidth
    imageView.layer.borderColor = Constants.DetailsAuthorAvatarConstants.avatarBorderColor
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var authorNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 2
    label.textAlignment = .center
    return label
  }()
  
  lazy var creationDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 1
    label.textAlignment = .center
    return label
  }()
  
  lazy var postLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  lazy var idLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  lazy private var labelStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .fillProportionally
    stackView.spacing = Constants.LabelStackViewConstants.stackViewSpacing
    stackView.addArrangedSubview(authorNameLabel)
    stackView.addArrangedSubview(postLabel)
    stackView.addArrangedSubview(idLabel)
    stackView.addArrangedSubview(creationDateLabel)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  lazy var likesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()
  
  lazy var viewsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()
  
  lazy var commentsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .systemOrange
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 0
    label.textAlignment = .left
    return label
  }()
  
  lazy private var footerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = Constants.FooterStackViewConstants.stackViewSpacing
    stackView.addArrangedSubview(likesLabel)
    stackView.addArrangedSubview(viewsLabel)
    stackView.addArrangedSubview(commentsLabel)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDetailsVC()
    setupLayouts()
  }
  
  private func setupDetailsVC() {
    guard let post = post else { return }
    title = post.author.name
    view.backgroundColor = .black
    self.authorNameLabel.text = Constants.LabelPlaceholder.nameLabelPlaceholder + post.author.name
    if let url = post.author.photo?.data.extraSmall.url {
      let cachekey = NSString(string: url.absoluteString)
      self.thumbnailImageView.image = cache.object(forKey: cachekey)
    }
    self.creationDateLabel.text = Constants.LabelPlaceholder.dateLabelPlaceholder + post.createdAt
    self.idLabel.text = Constants.LabelPlaceholder.idLabelPlaceholder + post.id
    self.postLabel.text = Constants.LabelPlaceholder.postLabelPlaceholder + (post.contents?.first?.data.value ?? Constants.DefaultValue.defaultPostText)
    self.likesLabel.text = Constants.LabelPlaceholder.likesLabelPlaceholder + String(post.stats.likes.count ?? 0)
    self.viewsLabel.text = Constants.LabelPlaceholder.viewsLabelPlaceholder + String(post.stats.likes.count ?? 0)
    self.commentsLabel.text = Constants.LabelPlaceholder.commentsLabelPlaceholder + String(post.stats.comments.count ?? 0)
  }
  
  private func setupLayouts() {
    
    view.addSubview(detailsLabel)
    view.addSubview(thumbnailImageView)
    view.addSubview(labelStackView)
    view.addSubview(footerStackView)
    
    NSLayoutConstraint.activate([
      detailsLabel.topAnchor.constraint(
        equalTo: view.topAnchor,
        constant: Constants.DetailsVCLayoutsConstants.detailsLabelTopAnchor
      ),
      detailsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      thumbnailImageView.topAnchor.constraint(
        equalTo: detailsLabel.bottomAnchor,
        constant: Constants.DetailsVCLayoutsConstants.thumbnailImageViewTopAnchor
      ),
      thumbnailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.DetailsVCLayoutsConstants.thumbnailImageViewWidthAnchor),
      thumbnailImageView.heightAnchor.constraint(equalToConstant: Constants.DetailsVCLayoutsConstants.thumbnailImageViewHeightAnchor),
      
      labelStackView.topAnchor.constraint(
        equalTo: thumbnailImageView.bottomAnchor,
        constant: Constants.DetailsVCLayoutsConstants.labelStackViewTopAnchor
      ),
      labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      labelStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
      
      footerStackView.topAnchor.constraint(
        equalTo: labelStackView.bottomAnchor,
        constant: Constants.DetailsVCLayoutsConstants.detailsLabelTopAnchor
      ),
      footerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
  
}
