//
//  CityDetailContract.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import Foundation

protocol CityDetailView: AnyObject {
    var presenter: CityDetailPresenter? { get set }
    
    func setCityLabel(with text: String)
    func setTempLabel(with text: String)
    func setConditionsLabel(with text: String) 
    func reloadData()
}

protocol CityDetailPresenter: AnyObject {
    var view: CityDetailView? { get set }
    var interactor: CityDetailInteractorInput? { get set }
    var wireframe: CityDetailWireframe? { get set }
    
    var forecastInfo: ForecastInfo? { get set }
    func getNumberOfCollectionItems() -> Int
    
    func viewDidLoad(view: CityDetailView)
    func getHourCellData(for row: Int) -> HourCellData?
    func getWeekDayCellData(for row: Int) -> WeekDayCellData?
}

protocol CityDetailInteractorInput: AnyObject {
    var output: CityDetailInteractorOutput? { get set }
}

protocol CityDetailInteractorOutput: AnyObject {

}

protocol CityDetailWireframe: AnyObject {
    static func createCityDetailModule(view: CityDetailView)
}
