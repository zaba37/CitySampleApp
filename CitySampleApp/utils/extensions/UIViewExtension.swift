//
//  UIViewExtension.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

extension UIView {
    func anchor (top: NSLayoutYAxisAnchor? = nil,
                 paddingTop: CGFloat = 0,
                 leading: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0,
                 bottom: NSLayoutYAxisAnchor? = nil,
                 paddingBottom: CGFloat = 0,
                 trailing: NSLayoutXAxisAnchor? = nil,
                 paddingRight: CGFloat = 0,
                 width: CGFloat = 0,
                 height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
