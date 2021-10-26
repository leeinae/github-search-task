//
//  SearchViewController.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/23.
//

import SnapKit
import UIKit

class SearchViewController: UIViewController {
    // MARK: - UIComponenets

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "search repository"
        bar.delegate = self
        
        return bar
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(cellType: SearchResultTableViewCell.self)
        table.keyboardDismissMode = .onDrag
        
        return table
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        
        return indicator
    }()
    
    lazy var tableLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        tableView.tableFooterView = indicator
        
        return indicator
    }()
    
    lazy var noResultImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100))
        imageView.isHidden = true
        
        return imageView
    }()
    
    lazy var noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.isHidden = true
        
        return label
    }()
    
    // MARK: - Properties
    
    let repositoryViewModel = RepositoryViewModel()
    var isFirst = true
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setViewModel()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    private func setView() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    private func setViewModel() {
        repositoryViewModel.results.bind { [weak self] searchResult in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            self?.noResultLabel.isHidden = !searchResult.isEmpty
            self?.noResultImage.isHidden = !searchResult.isEmpty
        }
        
        repositoryViewModel.isFetching.bind { [weak self] flag in
            self?.activityIndicator.isHidden = !flag
            
            flag ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            
            if let results = self?.repositoryViewModel.results.value, !results.isEmpty {
                flag ? self?.tableLoadingIndicator.startAnimating() : self?.tableLoadingIndicator.stopAnimating()
            }
        }
    }
    
    private func setConstraints() {
        view.addSubview(tableView)
        [activityIndicator, noResultImage, noResultLabel].forEach { tableView.addSubview($0) }
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        noResultImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        noResultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noResultImage.snp.bottom)
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositoryViewModel.results.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(cell: SearchResultTableViewCell.self, forIndexPath: indexPath)
        cell.setCell(repository: repositoryViewModel.results.value[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let keyword = searchBar.text else { return }
        
        if tableView.contentOffset.y > tableView.contentSize.height - tableView.bounds.size.height {
            if !repositoryViewModel.isFetching.value, repositoryViewModel.currPage < repositoryViewModel.maxPage {
                repositoryViewModel.currPage += 1

                repositoryViewModel.fetchSearchRepositoryResults(query: keyword)
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if repositoryViewModel.currPage < repositoryViewModel.maxPage {
//            let spinner = UIActivityIndicatorView(style: .large)
//            spinner.hidesWhenStopped = true
//            spinner.startAnimating()
//
//            tableView.tableFooterView = spinner
//        } else {
//            tableView.tableFooterView = nil
//        }
//    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        isFirst = false
        
        repositoryViewModel.results.value = []
        repositoryViewModel.currPage = 1
        repositoryViewModel.maxPage = 1
        
        repositoryViewModel.fetchSearchRepositoryResults(query: keyword)
        searchBar.resignFirstResponder()
    }
}
