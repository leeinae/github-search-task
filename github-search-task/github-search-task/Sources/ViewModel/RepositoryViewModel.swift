//
//  RepositoryViewModel.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation

class RepositoryViewModel {
    // MARK: - Properties

    var results = Observable([GithubRepository]())

    func fetchSearchRepositoryResults(query: String) {
        SearchService.shared.fetchSearchRepositories(query: query, page: 1) { [weak self] response in
            if let results = response.items {
                self?.results.value.append(contentsOf: results)
            }
        }
    }
}
