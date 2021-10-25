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
    var isFetching = Observable(false)

    var currPage = 1
    var maxPage = 1
    var pageOffset: Int = 30

    // MARK: - Methods

    func fetchSearchRepositoryResults(query: String) {
        isFetching.value = true

        SearchService.shared.fetchSearchRepositories(query: query, page: currPage) { [weak self] response in
            if let results = response.items {
                self?.results.value.append(contentsOf: results)
            }

            if let totalCount = response.totalCount,
               let offset = self?.pageOffset
            {
                self?.maxPage = (totalCount / offset) + 1
            }
            self?.isFetching.value = false
        }
    }
}
