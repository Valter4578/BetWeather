//
//  CityDetailViewController.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import UIKit

class CityDetailViewController: UIViewController, CityDetailView {
    // MARK: - Properties
    private let collectionViewCellId = "HoursCollectionViewItem"
    private let tableViewCellId = "DayTableViewCell"
    
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
    
    lazy var hoursCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(HoursCollectionViewItem.self, forCellWithReuseIdentifier: collectionViewCellId)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.borderWidth = 2
        collectionView.layer.cornerRadius = 15
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var weekDaysTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DayTableViewCell.self, forCellReuseIdentifier: tableViewCellId)
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 2
        tableView.layer.cornerRadius = 15
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupCityLabel()
        setupTemperatureLabel()
        setupConditionLabel()
        
        setupCollectionView()
        setupTableView()
        
        presenter?.viewDidLoad(view: self)
    }
    
    // MARK: - CityDetailView functions
    func setCityLabel(with text: String) {
        cityNameLabel.text = text
    }
    
    func setTempLabel(with text: String) {
        temperatureLabel.text = text
    }
    
    func setConditionsLabel(with text: String) {
        conditionLabel.text = text
    }
    
    func updateCellImage(_ image: UIImage, at index: Int, in viewType: CityDetailImageInViewType) {
        switch viewType {
        case .collectionView:
            if let item = self.hoursCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? HoursCollectionViewItem {
                item.configureImageView(with: image)
            }
        case .tableView:
            if let cell = self.weekDaysTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? DayTableViewCell {
                cell.configureImageView(with: image)
            }
        }
    }
}

// MARK: - CityDetailViewController+Setup
extension CityDetailViewController  {
    private func setupCityLabel() {
        view.addSubview(cityNameLabel)
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    private func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    private func setupConditionLabel() {
        view.addSubview(conditionLabel)
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(hoursCollectionView)
        NSLayoutConstraint.activate([
            hoursCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            hoursCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            hoursCollectionView.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 50),
            hoursCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 6.5),
        ])
    }
    
    private func setupTableView() {
        view.addSubview(weekDaysTableView)
        NSLayoutConstraint.activate([
            weekDaysTableView.topAnchor.constraint(equalTo: hoursCollectionView.bottomAnchor, constant: 30),
            weekDaysTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            weekDaysTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            weekDaysTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UICollectionViewDelegate
extension CityDetailViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CityDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getNumberOfCollectionItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as? HoursCollectionViewItem else { fatalError("Couldn't dequeue HoursCollectionViewItem")}
        if let cellData = presenter?.getHourCellData(for: indexPath.row) {
            cell.configureCell(with: cellData)
            presenter?.loadImage(with: cellData.iconName, at: indexPath.row, in: .collectionView)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = hoursCollectionView.frame.height
        return CGSize(width: 50, height: size)
    }
}

// MARK: - UITableViewDelegate
extension CityDetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension CityDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as? DayTableViewCell else { fatalError("Couldn't dequeue with DayTableViewCell identifier") }
        if let cellData = presenter?.getWeekDayCellData(for: indexPath.row) {
            cell.configureCell(with: cellData)
            presenter?.loadImage(with: cellData.iconName, at: indexPath.row, in: .tableView)
        }
        return cell
    }
}
