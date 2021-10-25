//
//  Date+.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/25.
//

import Foundation

extension Date {
    func dateToString(format: String = "yyyy/MM/dd HH:mm:ss", date: Self) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: date)
    }
}
