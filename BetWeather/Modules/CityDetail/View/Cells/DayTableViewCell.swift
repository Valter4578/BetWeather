//
//  DayTableViewCell.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 25.09.2024.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    // MARK: - Views
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var highestTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lowestTempLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWeekDayLabel()
        setupIconImageView()
        setupHighestTempLabel()
        setupLowestTempLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func configureCell(with data: WeekDayCellData) {
        weekDayLabel.text = data.weekDay
        lowestTempLabel.text = String(data.lowestTemp)
        highestTempLabel.text = String(data.highestTemp)
    }
    
    func configureImageView(with image: UIImage) {
        iconImageView.image = image 
    }
    
    // MARK: - Setup
    private func setupWeekDayLabel() {
        addSubview(weekDayLabel)
        NSLayoutConstraint.activate([
            weekDayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weekDayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: weekDayLabel.trailingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupLowestTempLabel() {
        addSubview(lowestTempLabel)
        NSLayoutConstraint.activate([
            lowestTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            lowestTempLabel.trailingAnchor.constraint(equalTo: highestTempLabel.leadingAnchor, constant: -15),
        ])
    }
    
    private func setupHighestTempLabel() {
        addSubview(highestTempLabel)
        NSLayoutConstraint.activate([
            highestTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            highestTempLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

