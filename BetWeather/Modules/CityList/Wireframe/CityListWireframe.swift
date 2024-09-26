//
//  CityListWireframe.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import UIKit
class CityListWireframeImpl: CityListWireframe {
    func pushToDetail(with forecastInfo: ForecastInfo, _ cityInfo: CityInfo, from view: UIViewController) {
        guard let detailView = CityDetailViewController() as? CityDetailView & UIViewController else { return }
        CityDetailWireframeImpl.createCityDetailModule(view: detailView)
        detailView.presenter?.forecastInfo = forecastInfo
        detailView.presenter?.cityInfo = cityInfo
        view.navigationController?.pushViewController(detailView, animated: true)
    }
    
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
