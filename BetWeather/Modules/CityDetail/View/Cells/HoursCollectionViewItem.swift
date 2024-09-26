//
//  HoursCollectionViewItem.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 25.09.2024.
//

import UIKit

class HoursCollectionViewItem: UICollectionViewCell {
    // MARK: - Views
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImageView()
        setupHourLabel()
        setupTempLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupHourLabel() {
        contentView.addSubview(hourLabel)
        NSLayoutConstraint.activate([
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
        ])
    }
    
    private func setupImageView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setupTempLabel() {
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
        ])
    }
    
    // MARK: - Configure Functions
    func configureCell(with data: HourCellData) {
        hourLabel.text = String(data.hour)
        tempLabel.text = String(data.temp) + "°"
    }
    
    func configureImageView(with image: UIImage) {
        imageView.image = image
    }
}
