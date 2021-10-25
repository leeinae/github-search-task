//
//  SearchAPI.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation
import Moya

enum SearchAPI {
    case getSearchRepositories(query: String, page: Int = 1)
}

extension SearchAPI: TargetType {
    var baseURL: URL {
        URL(string: BaseAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .getSearchRepositories:
            return "/search/repositories"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getSearchRepositories:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getSearchRepositories(let query, let page):
            return .requestParameters(parameters: ["q": query, "page": page], encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getSearchRepositories:
            return ["Accept": "application/vnd.github.v3+json",
                    "Content-Type": "application/json"]
        }
    }
}
