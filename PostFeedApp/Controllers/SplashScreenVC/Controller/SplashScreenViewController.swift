//
//  SplashScreenViewController.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 28.05.2021.
//

import UIKit

class SplashScreenViewController: UIViewController {
  
  private func createCircleView() -> UIView {
    let view = UIView()
    view.backgroundColor = .systemOrange
    view.layer.cornerRadius = Constants.Loading.loadingCircleCornerRadius
    view.alpha = 0
    return view
  }
  
  lazy private var stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = Constants.LoadingStackViewConstants.stackViewSpacing
    for index in 0..<3 {
      stackView.addArrangedSubview(createCircleView())
    }
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  lazy  var loadingLabel: UILabel = {
    let label = UILabel()
    label.text = Constants.LabelPlaceholder.loadingLabelText
    label.textColor = .systemOrange
    label.font = .nameLabelFont
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupLayouts()
    startAnimating()
    getData()
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.barTintColor = .black
    navigationController?.navigationBar.isTranslucent = false
    view.backgroundColor = .black
  }
  
  private func getData() {
    let request = GetPostsRequest(cursor: nil)
    NetworkManager.shared.request(request: request) { [weak self] completion in
      switch completion {
      case .failure(let error): print(error)
      case .success(let result):
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.Loading.animationTime) { [weak self] in
          self?.setupEndOfAnimation(with: result)
        }
      }
    }
  }
  
  private func setupLayouts() {
    view.addSubview(loadingLabel)
    view.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      loadingLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      loadingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      stackView.heightAnchor.constraint(equalToConstant: Constants.LoadingStackViewConstants.height),
      stackView.widthAnchor.constraint(equalToConstant: Constants.LoadingStackViewConstants.width),
      stackView.topAnchor.constraint(
        equalTo: self.loadingLabel.bottomAnchor,
        constant: Constants.LoadingStackViewConstants.stackViewTopAnchor
      )
    ])
  }
  
  private func setupEndOfAnimation(with item: PostDTO) {
    self.view.subviews.forEach {
      $0.removeFromSuperview()
    }
    let vc = PostsViewController()
    vc.model.cursor = item.data.cursor
    vc.model.items = item.data.items
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  private func startAnimating() {
    for (index, view) in stackView.subviews.reversed().enumerated() {
      UIView.animate(
        withDuration: Constants.Loading.animationDurationForCircle,
        delay: TimeInterval(Constants.Loading.animationDelayForCircle / Double(index + 1)),
        options: [.repeat, .autoreverse],
        animations: {
          view.alpha = 1
        })
    }
  }
}
