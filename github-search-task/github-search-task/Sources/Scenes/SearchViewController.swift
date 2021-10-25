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
        
        return table
    }()
    
    // MARK: - Properties
    
    var results: [GithubRepository] = []
    let repositoryViewModel = RepositoryViewModel()
    
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
        repositoryViewModel.results.bind { [weak self] results in
            self?.results = results
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReusableCell(cell: SearchResultTableViewCell.self, forIndexPath: indexPath)
        cell.setCell(repository: results[indexPath.row])
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let keyword = searchBar.text else { return }
        
        if tableView.contentOffset.y > tableView.contentSize.height - tableView.bounds.size.height {
            if !repositoryViewModel.isFetching, repositoryViewModel.currPage < repositoryViewModel.maxPage {
                repositoryViewModel.currPage += 1

                repositoryViewModel.fetchSearchRepositoryResults(query: keyword)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        repositoryViewModel.fetchSearchRepositoryResults(query: keyword)
    }
}
