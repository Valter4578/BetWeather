//
//  CityListViewController.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import CoreLocation
import UIKit

class CityListViewController: UIViewController, CityListView, CLLocationManagerDelegate {
    // MARK: - Dependencies
    weak var presenter: CityListPresenter?
    var locationManager: CLLocationManager?
    
    // MARK: - Properties
    
    // MARK: - Private properties
    private let cellId = "CityListViewControllerCellId"
    
    // MARK: - Views
    lazy var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CityListTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        presenter?.viewDidLoad(view: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    guard let coordinate = manager.location?.coordinate else { return }
                    presenter?.didGetLocation(lat: coordinate.latitude, lon: coordinate.longitude)
                }
            }
        }
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

