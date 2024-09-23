//
//  CityListPresenter.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

final class CityListPresenterImpl: CityListPresenter {
    // MARK: - Dependencies
    weak var view: CityListView?
    var router: CityListWireframe?
    var interactor: CityListInteractorInput?
    var wireframe: CityListWireframe?

    // MARK: - Properties
    var usersCoordinate: Coordinates?

    // MARK: - Functions
    func viewDidLoad(view: CityListView) {
        self.view = view
    }
    
    func didGetLocation(lat: Double, lon: Double) {
        self.usersCoordinate = Coordinates(lat: lat, lon: lon)
        
        if let usersCoordinate = usersCoordinate {
            interactor?.fetchWeather(for: usersCoordinate)
        }
    } 
}

extension CityListPresenterImpl: CityListInteractorOutput {
    func weatherFetched(forecastInfo: ForecastInfo) {
        
    }
}
