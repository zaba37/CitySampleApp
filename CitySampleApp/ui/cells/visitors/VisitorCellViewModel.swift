//
//  VisitorCellViewModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class VisitorCellViewModel: VisitorCellViewModelType {
    
    //MARK: - Properties
    let visitor: Visitor
    
    //MARK: - Life cycle
    init(visitor: Visitor) {
        self.visitor = visitor
    }
    
    //MARK: - getters
    var visitorName: String {
        return visitor.name
    }
}

extension VisitorCellViewModel: CellViewModelType {
    static func registerCell(tableView: UITableView) {
        tableView.register(VisitorTableViewCell.self, forCellReuseIdentifier: VisitorTableViewCell.identifier)
    }
    
    func dequeueCell(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VisitorTableViewCell.identifier, for: indexPath) as? VisitorTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: self)
        return cell
    }
}

