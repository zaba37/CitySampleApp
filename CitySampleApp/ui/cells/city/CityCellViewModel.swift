//
//  CityCellViewModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

import UIKit

class CityCellViewModel: CityCellViewModelType {
 
    //MARK: - Properties
    let city: City
    
    //MARK: - Life cycle
    init(city: City) {
        self.city = city
    }
    
    //MARK: - getters
    var cityName: String {
        return city.name
    }
    
    var previewUrl: String {
        return city.previewUrl
    }
}

extension CityCellViewModel: CellViewModelType {
    static func registerCell(tableView: UITableView) {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    func dequeueCell(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(with: self)
        return cell
    }
}
