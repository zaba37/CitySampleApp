//
//  VisitorTableViewCell.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class VisitorTableViewCell: UITableViewCell {
 
    //MARK: - Views
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
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
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor,
                         paddingTop: 16,
                         leading: leadingAnchor,
                         paddingLeft: 16,
                         bottom: bottomAnchor,
                         paddingBottom: 16,
                         trailing: trailingAnchor,
                         paddingRight: 16)
    }
    
    //MARK: - Setup
    func setup(with viewModel: VisitorCellViewModelType) {
        nameLabel.text = viewModel.visitorName
    }
}
