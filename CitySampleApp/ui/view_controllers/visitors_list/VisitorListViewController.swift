//
//  VisitorListViewController.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import UIKit

class VisitorListViewController: BaseViewController, BindableView {
    
    //MARK: - Injected properties
    @Injected var viewModel: VisitorListViewModelType
    
    //MARK: - Private properties
    private var tableView: UITableView!
    private var closeButton: UIButton!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        setupUI()
        bindViewModel()
    }
    
    //MARK: - UISetup
    private func createView() {
        closeButton = UIButton()
        closeButton.setTitle("Close".localized, for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           paddingTop: 8,
                           trailing: view.safeAreaLayoutGuide.trailingAnchor,
                           paddingRight: 4,
                           width: 60,
                           height: 20)
        
        tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
        tableView.anchor(top: closeButton.bottomAnchor,
                         paddingTop: 4,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         paddingLeft: 0,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         paddingBottom: 0,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor,
                         paddingRight: 0,
                         width: 0,
                         height: 0)
    }
    
    private func setupUI() {
        viewModel.cellViewModelTypes.forEach { $0.registerCell(tableView: tableView) }
        tableView.dataSource = self
        
        closeButton.addTarget(self, action: #selector(VisitorListViewController.dismisAction), for: .touchUpInside)
    }
    
    //MARK: - Data binding
    func bindViewModel() {
        viewModel.didUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    //MARK: - Actions
    @objc func dismisAction() {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension VisitorListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.visitorsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.visitorViewModel(atRow: indexPath.row)?.dequeueCell(tableView: tableView, atIndexPath: indexPath) ?? UITableViewCell()
    }
}

