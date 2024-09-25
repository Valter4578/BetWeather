//
//  CityListViewController.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import CoreLocation
import UIKit

class CityListViewController: UIViewController, CityListView {
    // MARK: - Dependencies
    var presenter: CityListPresenter?
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
        
        CityListWireframeImpl.createCityListModule(cityListView: self)
        
        setupTableView()
        
        presenter?.viewDidLoad(view: self)
        setupLocationManager()
    }
    
    // MARK: - Functions
    func reloadData() {
        citiesTableView.reloadData()
    }
    
    
    // MARK: - Private
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    private func setupTableView() {
        view.addSubview(citiesTableView)
        NSLayoutConstraint.activate([
            citiesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - CLLocationManagerDelegate
extension CityListViewController: CLLocationManagerDelegate  {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    guard let coordinate = manager.location?.coordinate else { return }
                    let latitude = coordinate.latitude
                    let longitude = coordinate.longitude
                    presenter?.didGetLocation(lat: latitude, lon: longitude)
                }
            }
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            presenter?.didGetLocation(lat: latitude, lon: longitude)
        }
    }
}

// MARK: - Table View Delegate
extension CityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cityInfos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CityListTableViewCell else { fatalError("Couldn't dequeue CityListTableViewCell") }
        if let cityInfo = presenter?.cityInfos[indexPath.row] {
            cell.locationTitleLabel.text = cityInfo.cityName
            cell.tempInfoLabel.text = "H: \(cityInfo.highestTemp) L: \(cityInfo.lowestTemp)"
            cell.temperatureLabel.text = "\(cityInfo.tempNow)"
        }
        return cell
    }
}

