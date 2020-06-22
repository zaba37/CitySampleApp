//
//  VisitorListViewModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class VisitorListViewModel: VisitorListViewModelType {
    
    //MARK: - Injected properties
    @Injected private var sceneCoordinator: SceneCoordinatorType
    
    //MARK: - Private properties
    private var visitorsCellViewModels = [VisitorCellViewModel]()
    
    //MARK: - Public properties
    let cellViewModelTypes: [CellViewModelType.Type] = [VisitorCellViewModel.self]
    
    //MARK: - Callbacks
    var didUpdate: (()->())?
    
    //MARK: - Life cycle
    init(visitors: [Visitor]) {
        self.prepareViewModels(for: visitors)
    }
    
    //MARK: - Utils
    private func prepareViewModels(for visitorsList: [Visitor]) {
        visitorsCellViewModels = visitorsList.map { VisitorCellViewModel(visitor: $0) }
        didUpdate?()
    }
    
    //MARK: - Getters
    var visitorsCount: Int {
        return visitorsCellViewModels.count
    }
    
    func visitorViewModel(atRow row: Int) -> VisitorCellViewModel? {
        guard 0 ..< visitorsCount ~= row else {
            return nil
        }
        return visitorsCellViewModels[row]
    }
}
