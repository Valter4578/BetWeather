//
//  CityListPresenter.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation
import UIKit

final class CityListPresenterImpl: CityListPresenter {
    // MARK: - Dependencies
    weak var view: CityListView?
    var router: CityListWireframe?
    var interactor: CityListInteractorInput?
    var wireframe: CityListWireframe?

    // MARK: - Properties
    var usersCoordinate: Coordinates?
    var cityInfos: [CityInfo] = []
    
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
    
    func didGetCityName(_ name: String) {
        interactor?.fetchCityCoordinates(for: name)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let viewController = view as? UIViewController else { return }
        wireframe?.pushToDetail(with: cityInfos[indexPath.row].fullForecast, from: viewController)
    }
}

extension CityListPresenterImpl: CityListInteractorOutput {
    func coordinatesFetched(coordinates: Coordinates) {
        interactor?.fetchWeather(for: coordinates)
    }
    
    func weatherFetched(forecastInfo: ForecastInfo) {
        let cityInfo = CityInfo(cityName: forecastInfo.info?.tzinfo?.name ?? "", lowestTemp: forecastInfo.fact?.tempMin ?? 0, highestTemp: forecastInfo.fact?.tempMin ?? 0, tempNow: forecastInfo.fact?.temp ?? 0, fullForecast: forecastInfo)
        cityInfos.append(cityInfo)
        view?.reloadData() 
    }
}
