//
//  UITableView+.swift
//  github-search-task
//
//  Created by inae Lee on 2021/10/24.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(cell: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable Dequeue Reusable Cell")
        }

        return cell
    }

    func register<T: UITableViewCell>(cellType: T.Type) {
        let identifier = String(describing: T.self)

        self.register(cellType, forCellReuseIdentifier: identifier)
    }
}
