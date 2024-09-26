//
//  CityDetailWireframe.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import Foundation

class CityDetailWireframeImpl: CityDetailWireframe {
    class func createCityDetailModule(view: CityDetailView) {
        let interactor = CityDetailInteractorImpl()
        interactor.imageDownloader = ImageDownloaderImpl()
        
        let presenter: CityDetailPresenter & CityDetailInteractorOutput = CityDetailPresenterImpl()
        
        view.presenter = presenter
        view.presenter?.wireframe = CityDetailWireframeImpl()
        view.presenter?.view = view
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.output = presenter
    }
}
