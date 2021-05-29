//
//  ViewController.swift
//  PostFeedApp
//
//  Created by NIKOLAI BORISOV on 26.05.2021.
//

import UIKit

class PostsViewController: UIViewController, UISearchControllerDelegate {
  
  var model = ViewControllerModel()
  private var posts = [PostDTO.Data.Item]()
  
  private let searchController = UISearchController(searchResultsController: nil)
  var filteredPosts: [PostDTO.Data.Item] = []
  private var searchBarIsEmpty: Bool {
    guard let text = searchController.searchBar.text else { return false }
    return text.isEmpty
  }
  var isFiltering: Bool {
    return searchController.isActive && !searchBarIsEmpty
  }
  
  lazy private var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(
      ContentTableViewCell.self,
      forCellReuseIdentifier: Constants.CellConstants.contentTableViewCell
    )
    tableView.frame = self.view.frame
    tableView.delegate = self
    tableView.dataSource = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(tableView)
    self.setupNavigationBar()
    self.setupSearchController()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tableView.reloadData()
  }
  
  private func setupSearchController() {
    searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchController.searchResultsUpdater = self
    searchController.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = Constants.LabelPlaceholder.searchControllerPlaceholder
    searchController.searchBar.backgroundColor = .tertiarySystemGroupedBackground
    UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .systemOrange
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  private func setupNavigationBar() {
    title = Constants.VCTitle.postVCTitle
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.barTintColor = .black
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
    navigationController?.navigationBar.tintColor = .systemOrange
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .cancel,
      target: self,
      action: #selector(onCloseButtonDidTap)
    )
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: Constants.NavigationItemTitle.rightItemTitle,
      style: .done,
      target: self,
      action: #selector(onFilterButtonDidTap)
    )
  }
  
  @objc private func onFilterButtonDidTap() {
    let alertController = UIAlertController (
      title: AlertControllerConstants.alertControllerTitle,
      message: AlertControllerConstants.alertControllerMessage,
      preferredStyle: .alert
    )
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.mostPopularAction, style: .default, handler: { [weak self] _ in
        self?.getPosts(by: .mostPopular)
      }
    ))
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.mostCommentedAction, style: .default, handler: { [weak self] _ in
        self?.getPosts(by: .mostCommented)
      }
    ))
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.createdAtAction, style: .default, handler: { [weak self] _ in
        self?.getPosts(by: .createdAt)
      }
    ))
    
    alertController.addAction(UIAlertAction(
      title: AlertControllerConstants.cancelAction, style: .destructive, handler: nil
    ))
    
    DispatchQueue.main.async {
      self.present(alertController, animated: true)
    }
  }
  
  private func getPosts(by type: OrderType) {
    self.model.getPosts(by: type) { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  @objc private func onCloseButtonDidTap() {
    exit(0)
  }
  
  private func getPosts() {
    self.model.getPosts { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  private func presentDetailesController(for item: PostDTO.Data.Item) {
    let vc = DetailsViewController()
    vc.post = item
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.model.items[indexPath.row]
    var post: PostDTO.Data.Item
    if isFiltering {
      post = filteredPosts[indexPath.row]
      self.presentDetailesController(for: post)
    } else {
      self.presentDetailesController(for: item)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Constants.CellConstants.cellRowHeight
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let item = self.model.items[indexPath.row]
    var post: PostDTO.Data.Item
        if isFiltering {
          post = filteredPosts[indexPath.row]
          (cell as? ContentTableViewCell)?.configure(with: post)
        } else {
          (cell as? ContentTableViewCell)?.configure(with: item)
        }
    if indexPath.row == self.model.items.count - 1 {
      self.getPosts()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      return filteredPosts.count
    }
    return model.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: Constants.CellConstants.contentTableViewCell, for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if case .delete = editingStyle {
      self.model.items.remove(at: indexPath.row)
      self.tableView.reloadData()
    }
  }
  
}

extension PostsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text ?? "")
  }
  
  func filterContentForSearchText(_ searchText: String) {
    filteredPosts = posts.filter({(author: PostDTO.Data.Item) -> Bool in
      return author.id.lowercased().contains(searchText.lowercased())
    })
    tableView.reloadData()
  }
}
