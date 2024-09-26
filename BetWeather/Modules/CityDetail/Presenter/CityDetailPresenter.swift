//
//  CityDetailPresenter.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import Foundation
import UIKit

/// enum для опеределения в какую view вставлять изображение
enum CityDetailImageInViewType {
    case collectionView
    case tableView
}

class CityDetailPresenterImpl: CityDetailPresenter {
    
    // MARK: - Dependencies
    var wireframe: CityDetailWireframe?
    weak var view: CityDetailView?
    var interactor: CityDetailInteractorInput?
    
    // MARK: - Properties
    var forecastInfo: ForecastInfo?
    var cityInfo: CityInfo?
    
    // MARK: - CityDetailPresenter's functions
    func viewDidLoad(view: CityDetailView) {
        view.setCityLabel(with: cityInfo?.cityName ?? "")
        view.setTempLabel(with: String(forecastInfo?.fact?.temp ?? 0))
        view.setConditionsLabel(with: forecastInfo?.fact?.condition?.rawValue ?? "")
    }
    
    func getHourCellData(for row: Int) -> HourCellData? {
        let hour = getCurrentHour()
        guard let hourData = forecastInfo?.forecasts?[0].hours?[hour + row] else { return nil } // hour + row для того чтобы не показывать все часы, а начинать отчет с текущего
        
        return HourCellData(hour: Int(hourData.hour ?? "") ?? 0, iconName: hourData.icon ?? "", temp: hourData.temp ?? 0)
    }
    
    func getNumberOfCollectionItems() -> Int {
        guard let hours = forecastInfo?.forecasts?[0].hours else { return 0 }
        return hours.count - getCurrentHour()
    }
    
    func getWeekDayCellData(for row: Int) -> WeekDayCellData? {
        guard let forecast = forecastInfo?.forecasts?[row] else { return nil }
        
        // получения дня недели
        var date: Date?
        if let isoDate = forecast.date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            date = dateFormatter.date(from:isoDate)
        }
        let weekDay = date?.formatted(Date.FormatStyle().weekday(.abbreviated))
        
        // самую низкую температуру берем с ночи, самую высокую с дня
        let highestTemp = forecast.parts?.day?.tempMax
        let lowestTemp = forecast.parts?.night?.tempMin
        
        // берем иконку для дня 
        let iconName = forecast.parts?.day?.icon
        return WeekDayCellData(weekDay: weekDay ?? "", iconName: iconName ?? "", lowestTemp: lowestTemp ?? 0, highestTemp: highestTemp ?? 0)
    }
    
    func loadImage(with name: String, at index: Int, in viewType: CityDetailImageInViewType) {
        interactor?.downloadImage(with: name, for: index, in: viewType)
    }
    
    // MARK: - Private functions
    private func getCurrentHour() -> Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.hour, from: date)
    }
}

extension CityDetailPresenterImpl: CityDetailInteractorOutput {
    func imageDownloaded(with image: UIImage, for index: Int, in viewType: CityDetailImageInViewType) {
        Task {
            await MainActor.run {
                view?.updateCellImage(image, at: index, in: viewType)
            }
        }
    }
}
