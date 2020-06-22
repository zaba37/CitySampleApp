//
//  CityDetailsViewController.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class CityDetailsViewController: BaseViewController, BindableView {
    
    //MARK: - Injected properties
    @Injected var viewModel: CityDetailsViewModelType
    
    //MARK: - Private properties
    private var imageView: UIImageView!
    private var favoriteButton: UIButton!
    private var visitorsLabel: UILabel!
    private var ratingLabel: UILabel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        setupUI()
        bindViewModel()
    }
    
    //MARK: - UISetup
    private func createView() {
        imageView = UIImageView()
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         paddingTop: 0,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         paddingLeft: 0,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor,
                         paddingRight: 0)
        
        visitorsLabel = UILabel()
        view.addSubview(visitorsLabel)
        visitorsLabel.anchor(top: imageView.bottomAnchor,
                             paddingTop: 8,
                             leading: view.safeAreaLayoutGuide.leadingAnchor,
                             paddingLeft: 8,
                             trailing: view.safeAreaLayoutGuide.trailingAnchor,
                             paddingRight: 8)
        
        ratingLabel = UILabel()
        view.addSubview(ratingLabel)
        ratingLabel.anchor(top: visitorsLabel.bottomAnchor,
                           paddingTop: 8,
                           leading: view.safeAreaLayoutGuide.leadingAnchor,
                           paddingLeft: 8,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           paddingRight: 8)
        
        favoriteButton = UIButton()
        view.addSubview(favoriteButton)
        updateButtonState()
        favoriteButton.layer.borderColor = UIColor.black.cgColor
        favoriteButton.layer.borderWidth = 1
        favoriteButton.anchor(leading: view.safeAreaLayoutGuide.leadingAnchor,
                              paddingLeft: 8,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor,
                              paddingRight: 8,
                              height: 40)
    }
    
    private func setupUI() {
        title = viewModel.cityName
        imageView.loadImageUsingCache(withUrl: viewModel.previewUrl)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CityDetailsViewController.showVisitorsList))
        visitorsLabel.addGestureRecognizer(tap)
        visitorsLabel.isUserInteractionEnabled = true
        
        favoriteButton.addTarget(self, action: #selector(CityDetailsViewController.favoriteButtonAction), for: .touchUpInside)
    }
    
    private func updateButtonState() {
        let image = viewModel.isFavorite ? UIImage.favoriteImage : UIImage.unfavoriteImage
        favoriteButton.setImage(image, for: .normal)
    }
    
    //MARK: - Data binding
    func bindViewModel() {
        viewModel.didUpdate = { [weak self] (updateType, value) in
            switch updateType {
            case .visitors:
                self?.visitorsLabel.isHidden = false
                self?.visitorsLabel.text = value
            case .rating:
                self?.ratingLabel.isHidden = false
                self?.ratingLabel.text = value
            case .favoriteSave:
                self?.updateButtonState()
            }
        }
        
        viewModel.didError = { [weak self] (updateType, error) in
            switch updateType {
            case .visitors:
                self?.visitorsLabel.isHidden = true
            case .rating:
                self?.ratingLabel.isHidden = true
            case .favoriteSave:
                self?.updateButtonState()
            }
            
            self?.showAlert(message: error.localizedDescription, cancelTitle: "Cancel".localized)
        }
        
        viewModel.didLoadData = { [weak self] in
            self?.hideLoading()
        }

        showLoading()
        viewModel.loadData()
    }
    
    //MARK: - Actions
    @objc func showVisitorsList() {
        viewModel.showVisitorsList()
    }
    
    @objc func favoriteButtonAction() {
        viewModel.toggleFavorite()
    }
}
