//
//  SearchService.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/23.
//

import Moya

final class SearchService {
    static let shared = SearchService()
    static let provider = MoyaProvider<SearchAPI>()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }()

    private init() {}

    func fetchSearchRepositories(query: String, page: Int = 1, completion: @escaping (SearchResult) -> Void) {
        SearchService.provider.request(.getSearchRepositories(query: query, page: page)) { result in
            switch result { case .success(let response):
                do {
                    let json = try self.decoder.decode(SearchResult.self, from: response.data)

                    completion(json)
                } catch {
                    print("Decode Erorr", error)
                }
            case .failure(let error):
                print("Network Error", error)
            }
        }
    }
}
