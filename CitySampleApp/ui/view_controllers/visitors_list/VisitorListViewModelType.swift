//
//  VisitorListViewModelType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

protocol VisitorListViewModelType {
    var didUpdate: (()->())? { get set }
    var cellViewModelTypes: [CellViewModelType.Type] { get }
    var visitorsCount: Int { get }
    
    func visitorViewModel(atRow row: Int) -> VisitorCellViewModel?
}
