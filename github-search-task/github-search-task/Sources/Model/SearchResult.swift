//
//  SearchResult.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation

// MARK: - SearchResult

struct SearchResult: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
