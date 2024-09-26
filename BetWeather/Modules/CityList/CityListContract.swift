//
//  CityListContract.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import UIKit

protocol CityListView: AnyObject {
    func reloadData() 
}

protocol CityListPresenter: AnyObject {
    var view: CityListView? { get set }
    var interactor: CityListInteractorInput? { get set }
    var wireframe: CityListWireframe? { get set }
    
    var usersCoordinate: Coordinates? { get set }
    var cityInfos: [CityInfo] { get set } 
    
    func viewDidLoad(view: CityListView)
    
    func didGetLocation(lat: Double, lon: Double)
    func didGetCityName(_ name: String) 
    
    func didSelectRow(at indexPath: IndexPath)
}

protocol CityListInteractorInput: AnyObject {
    var output: CityListInteractorOutput? { get set }
    func fetchWeather(for coordinates: Coordinates)
    func fetchCityCoordinates(for city: String)
    func getCityName(from coordinates: Coordinates) async -> String?
}

protocol CityListInteractorOutput: AnyObject {
    func weatherFetched(forecastInfo: ForecastInfo)
    func coordinatesFetched(coordinates: Coordinates)
}

protocol CityListWireframe: AnyObject {
    func pushToDetail(with forecastInfo: ForecastInfo, from view: UIViewController)
    static func createCityListModule(cityListView: CityListViewController)
}
