//
//  CellViewModelType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

protocol CellViewModelType {
    static func registerCell(tableView: UITableView)
    func dequeueCell(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}
