//
//  BaseViewControllerv.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 21/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Private properties
    private let activityView: UIActivityIndicatorView = {
        if #available(iOS 13, *) {
            return UIActivityIndicatorView(style: .medium)
        } else {
            return UIActivityIndicatorView(style: .gray)
        }
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActivityIndicatorView()
    }
    
    private func setupView() {
        if #available(iOS 13, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .clear
        }
    }
    
    private func setupActivityIndicatorView() {
        activityView.center = view.center
    }
    
    //MARK: - Loading
    func showLoading() {
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func hideLoading() {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
}
