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
    func viewDidLoad(view: CityListView)
}

protocol CityListInteractorInput: AnyObject {
}

protocol CityListInteractorOutput: AnyObject {
    func weatherFetched()
}

protocol CityListRouter: AnyObject {
}

protocol CityListRepo: AnyObject {

}
