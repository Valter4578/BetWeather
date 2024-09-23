//
//  CityListViewController.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import UIKit

class CityListViewController: UIViewController, CityListView {
    // MARK: - Dependencies
    weak var presenter: CityListPresenter?
    
    // MARK: - Properties
    
    // MARK: - Private properties
    private let cellId = "CityListViewControllerCellId"
    
    // MARK: - Views
    lazy var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad(view: self)
    }
    
}

// MARK: - Table View Delegate
extension CityListViewController: UITableViewDelegate {
    
}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CityListTableViewCell else { fatalError("Couldn't dequeue CityListTableViewCell") }
        
        return cell 
    }
}
