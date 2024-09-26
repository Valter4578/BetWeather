//
//  CityDetailContract.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import UIKit

protocol CityDetailView: AnyObject {
    var presenter: CityDetailPresenter? { get set }
    
    func setCityLabel(with text: String)
    func setTempLabel(with text: String)
    func setConditionsLabel(with text: String) 
    func reloadData()
    
    func updateCellImage(_ image: UIImage, at index: Int, in viewType: CityDetailImageInViewType)
}

protocol CityDetailPresenter: AnyObject {
    var view: CityDetailView? { get set }
    var interactor: CityDetailInteractorInput? { get set }
    var wireframe: CityDetailWireframe? { get set }
    
    var forecastInfo: ForecastInfo? { get set }
    var cityInfo: CityInfo? { get set }
    func getNumberOfCollectionItems() -> Int
    
    func viewDidLoad(view: CityDetailView)
    func getHourCellData(for row: Int) -> HourCellData?
    func getWeekDayCellData(for row: Int) -> WeekDayCellData?
    
    func loadImage(with name: String, at index: Int, in viewType: CityDetailImageInViewType)
}

protocol CityDetailInteractorInput: AnyObject {
    var output: CityDetailInteractorOutput? { get set }
    
    func downloadImage(with iconName: String, for index: Int, in viewType: CityDetailImageInViewType)
}

protocol CityDetailInteractorOutput: AnyObject {
    func imageDownloaded(with image: UIImage, for index: Int, in viewType: CityDetailImageInViewType)
}

protocol CityDetailWireframe: AnyObject {
    static func createCityDetailModule(view: CityDetailView)
}
