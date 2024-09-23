//
//  CityListWireframe.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation
class CityListWireframeImpl: CityListWireframe {
    
    class func createCityListModule(cityListView: CityListViewController) {
        let networkRepository = NetworkRepositoryImpl(networkService: NetworkService())
        let interactor = CityListInteractorImpl(networkRepository: networkRepository)
        let presenter: CityListPresenter & CityListInteractorOutput = CityListPresenterImpl()
        
        cityListView.presenter = presenter
        cityListView.presenter?.wireframe = CityListWireframeImpl()
        cityListView.presenter?.view = cityListView
        cityListView.presenter?.interactor = interactor
        cityListView.presenter?.interactor?.output = presenter
    } 
}
