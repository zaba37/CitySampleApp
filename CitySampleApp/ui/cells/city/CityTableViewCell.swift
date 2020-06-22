//
//  CityTableViewCell.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
 
    //MARK: - Views
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let cellBottomContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        return view
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let favImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(cellImageView)
        cellImageView.anchor(top: topAnchor,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             height: 200)
        
        addSubview(cellBottomContentView)
        cellBottomContentView.anchor(leading: leadingAnchor,
                                     bottom: bottomAnchor,
                                     trailing: trailingAnchor,
                                     height: 40)
        
        cellBottomContentView.addSubview(nameLabel)
        nameLabel.anchor(top: cellBottomContentView.topAnchor,
                         paddingTop: 4,
                         leading: cellBottomContentView.leadingAnchor,
                         paddingLeft: 4,
                         bottom: cellBottomContentView.bottomAnchor,
                         paddingBottom: 4)
        
        cellBottomContentView.addSubview(favImageView)
        favImageView.anchor(top: cellBottomContentView.topAnchor,
                            paddingTop: 2,
                            leading: nameLabel.trailingAnchor,
                            bottom: cellBottomContentView.bottomAnchor,
                            paddingBottom: 2,
                            trailing: cellBottomContentView.trailingAnchor,
                            width: 36,
                            height: 36)
    }
    
    //MARK: - Setup
    func setup(with viewModel: CityCellViewModelType) {
        nameLabel.text = viewModel.cityName
        cellImageView.loadImageUsingCache(withUrl: viewModel.previewUrl)
        
        let image = viewModel.isFavorite ? UIImage.favoriteImage : UIImage.unfavoriteImage
        favImageView.image = image
    }
}
