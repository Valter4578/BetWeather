//
//  CityDetailPresenter.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import Foundation

class CityDetailPresenterImpl: CityDetailPresenter {
    
    var wireframe: CityDetailWireframe?
    weak var view: CityDetailView?
    var interactor: CityDetailInteractorInput?
    
    var forecastInfo: ForecastInfo?
    
    func viewDidLoad(view: CityDetailView) {
        view.setCityLabel(with: forecastInfo?.info?.tzinfo?.name ?? "")
        view.setTempLabel(with: String(forecastInfo?.fact?.temp ?? 0))
        view.setConditionsLabel(with: forecastInfo?.fact?.condition?.rawValue ?? "")
    }
}

extension CityDetailPresenterImpl: CityDetailInteractorOutput {
    
}
