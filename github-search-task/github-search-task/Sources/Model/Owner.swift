//
//  Owner.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation

// MARK: - Owner

struct Owner: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let url, htmlURL, avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login, id, url
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}
