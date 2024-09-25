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
    
    func getHourCellData(for row: Int) -> HourCellData? {
        let hour = getCurrentHour()
        guard let hourData = forecastInfo?.forecasts?[0].hours?[hour + row] else { return nil } // hour + row для того чтобы не показывать все часы, а начинать отчет с текущего
        
        return HourCellData(hour: Int(hourData.hour ?? "") ?? 0, iconName: hourData.icon ?? "", temp: hourData.temp ?? 0)
    }
    
    func getNumberOfItems() -> Int {
        guard let hours = forecastInfo?.forecasts?[0].hours else { return 0 }
        return hours.count - getCurrentHour()
    }
    
    private func getCurrentHour() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
        
    }
}

extension CityDetailPresenterImpl: CityDetailInteractorOutput {
    
}
