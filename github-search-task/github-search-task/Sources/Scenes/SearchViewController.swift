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

    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "search repository"
        
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
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    private func setView() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
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
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell = tableView.dequeueReuableCell(cell: SearchResultTableViewCell.self, forIndexPath: indexPath)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {}
