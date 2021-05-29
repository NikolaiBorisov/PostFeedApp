//
//  ContentTableViewCell.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 28.05.2021.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
  
  let cache = NetworkManager.shared.cache
  
  lazy var thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = Constants.Image.avatarPlaceholder
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = Constants.AuthorAvatarConstants.avatarCornerRadius
    imageView.layer.borderWidth = Constants.AuthorAvatarConstants.avatarBorderWidth
    imageView.layer.borderColor = Constants.AuthorAvatarConstants.avatarBorderColor
    return imageView
  }()
  
  lazy var authorNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 1
    label.textAlignment = .left
    return label
  }()
  
  lazy var creationDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = UIFont.creationDateLabelFont
    label.numberOfLines = 1
    label.textAlignment = .left
    return label
  }()
  
  lazy var idLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = UIFont.creationDateLabelFont
    label.numberOfLines = 1
    label.textAlignment = .left
    return label
  }()
  
  lazy var postTextLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .label
    label.font = UIFont.nameLabelFont
    label.numberOfLines = 2
    label.minimumScaleFactor = 0.5
    label.textAlignment = .left
    return label
  }()
  
  func configure(with item: PostDTO.Data.Item) {
    
    self.authorNameLabel.text = Constants.LabelPlaceholder.nameLabelPlaceholder + item.author.name.uppercased()
    self.creationDateLabel.text = Constants.LabelPlaceholder.dateLabelPlaceholder + item.createdAt
    if let value = item.contents?.first,
       let text = value.data.value,
       text != "" {
      self.postTextLabel.text = Constants.LabelPlaceholder.postLabelPlaceholder + text
    } else {
      self.postTextLabel.text = Constants.LabelPlaceholder.postLabelPlaceholder + "..."
    }
    self.idLabel.text = Constants.LabelPlaceholder.idLabelPlaceholder + item.id
    guard let url = item.author.photo?.data.extraSmall.url else { return }
    let cacheKey = NSString(string: url.absoluteString)

    if let image = self.cache.object(forKey: cacheKey) {
      self.thumbnailImageView.image = image
      return
    }

    URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard error == nil else { return }
      guard let data = data, let image = UIImage(data: data) else { return }
      self?.cache.setObject(image, forKey: cacheKey)
      DispatchQueue.main.async {
        self?.thumbnailImageView.image = image
      }
    }.resume()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupLayouts()
    self.selectionStyle = .none
    self.backgroundColor = .tertiarySystemGroupedBackground
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayouts() {
    
    self.addSubview(thumbnailImageView)
    self.addSubview(authorNameLabel)
    self.addSubview(creationDateLabel)
    self.addSubview(postTextLabel)
    self.addSubview(idLabel)
    
    NSLayoutConstraint.activate([
      thumbnailImageView.leadingAnchor.constraint(
        equalTo: self.leadingAnchor,
        constant: Constants.PostCellLayoutsConstants.avatarleadingAnchor
      ),
      thumbnailImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.PostCellLayoutsConstants.avatarWidth),
      thumbnailImageView.heightAnchor.constraint(equalToConstant: Constants.PostCellLayoutsConstants.avatarHeight),
      
      authorNameLabel.topAnchor.constraint(
        equalTo: self.topAnchor,
        constant: Constants.PostCellLayoutsConstants.nameLabelTopAnchor
      ),
      authorNameLabel.leadingAnchor.constraint(
        greaterThanOrEqualTo: self.thumbnailImageView.trailingAnchor,
        constant: Constants.PostCellLayoutsConstants.nameLabelLeadingAnchor
      ),
      
      postTextLabel.topAnchor.constraint(
        equalTo: self.authorNameLabel.bottomAnchor,
        constant: Constants.PostCellLayoutsConstants.postLabelTopAnchor
      ),
      postTextLabel.leadingAnchor.constraint(
        equalTo: self.thumbnailImageView.trailingAnchor,
        constant: Constants.PostCellLayoutsConstants.postLabelLeadingAnchor
      ),
      postTextLabel.trailingAnchor.constraint(
        equalTo: self.trailingAnchor,
        constant: Constants.PostCellLayoutsConstants.postLabelTrailingAnchor
      ),
      
      creationDateLabel.topAnchor.constraint(
        equalTo: self.postTextLabel.bottomAnchor,
        constant: Constants.PostCellLayoutsConstants.dateLabelTopAnchor
      ),
      creationDateLabel.leadingAnchor.constraint(
        equalTo: self.thumbnailImageView.trailingAnchor,
        constant: Constants.PostCellLayoutsConstants.dateLabelLeadingnAnchor
      ),
      
      idLabel.topAnchor.constraint(
        equalTo: self.creationDateLabel.bottomAnchor,
        constant: Constants.PostCellLayoutsConstants.dateLabelTopAnchor
      ),
      idLabel.leadingAnchor.constraint(
        equalTo: self.thumbnailImageView.trailingAnchor,
        constant: Constants.PostCellLayoutsConstants.dateLabelLeadingnAnchor
      ),
      
      idLabel.bottomAnchor.constraint(
        equalTo: self.bottomAnchor,
        constant: Constants.PostCellLayoutsConstants.dateLabelBottomAnchor
      )
    ])
  }
  
}
