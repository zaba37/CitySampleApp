//
//  CollectionCellViewModelType.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

protocol CollectionCellViewModelType {
    static func registerCell(collectionView: UICollectionView)
    func dequeueCell(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell
}
