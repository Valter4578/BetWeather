//
//  CityDetailViewController.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import UIKit

class CityDetailViewController: UIViewController, CityDetailView {
    
    // MARK: - Dependencies
    var presenter: CityDetailPresenter?
    
    // MARK: - Views
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 37, weight: .regular)
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 102, weight: .thin)
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCityLabel()
        setupTemperatureLabel()
        setupConditionLabel()
        
        presenter?.viewDidLoad(view: self)
    }
    
    func setCityLabel(with text: String) {
        cityNameLabel.text = text
    }
    
    func setTempLabel(with text: String) {
        temperatureLabel.text = text
    }
    
    func setConditionsLabel(with text: String) {
        conditionLabel.text = text
    }
    
    func reloadData() {
        
    }
}

// MARK: - CityDetailViewController+Setup
extension CityDetailViewController  {
    private func setupCityLabel() {
        view.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    private func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupConditionLabel() {
        view.addSubview(conditionLabel)
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
