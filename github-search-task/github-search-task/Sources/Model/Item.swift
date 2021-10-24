//
//  Item.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation

// MARK: - Item

struct Item: Codable {
    let id: Int?
    let nodeID, name, fullName: String?
    let itemPrivate: Bool?
    let owner: Owner?
    let itemDescription: String?
    let url, htmlURL: String?
    let createdAt, updatedAt, pushedAt: Date?
    let size, stargazersCount, watchersCount: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, owner, url, size, language
        case nodeID = "node_id"
        case fullName = "full_name"
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case itemDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
    }
}
