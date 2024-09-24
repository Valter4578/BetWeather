//
//  CityListTableViewCell.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import UIKit

class CityListTableViewCell: UITableViewCell {

    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tempInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLocationLabel()
        setupTempLabel()
        setupTempInfoLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLocationLabel() {
        addSubview(locationTitleLabel)
        NSLayoutConstraint.activate([
            locationTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            locationTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    private func setupTempLabel() {
        addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            temperatureLabel.leadingAnchor.constraint(equalTo: locationTitleLabel.trailingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
    }
    
    private func setupTempInfoLabel() {
        addSubview(tempInfoLabel)
        NSLayoutConstraint.activate([
            tempInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tempInfoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
