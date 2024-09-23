//
//  CityListContract.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

protocol CityListView: AnyObject {
    
}

protocol CityListPresenter: AnyObject {
    var view: CityListView? { get set }
    var interactor: CityListInteractorInput? { get set }
    var wireframe: CityListWireframe? { get set }
    
    func viewDidLoad(view: CityListView)
    func didGetLocation(lat: Double, lon: Double) 
}

protocol CityListInteractorInput: AnyObject {
    var output: CityListInteractorOutput? { get set }
    func fetchWeather(for coordinates: Coordinates)
}

protocol CityListInteractorOutput: AnyObject {
    func weatherFetched(forecastInfo: ForecastInfo)
}

protocol CityListWireframe: AnyObject {
    static func createCityListModule(cityListView: CityListViewController) 
}

protocol CityListRepo: AnyObject {

}
