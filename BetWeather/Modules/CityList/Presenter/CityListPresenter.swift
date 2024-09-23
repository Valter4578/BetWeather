//
//  CityListPresenter.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

final class CityListPresenterImpl: CityListPresenter {
    
    private weak var view: CityListView?
    private let router: CityListRouter
    private let interactor: CityListInteractorInput

    init(router: CityListRouter, interactor: CityListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }

    func viewDidLoad(view: CityListView) {
        self.view = view
        
    }
}

extension CityListPresenterImpl: CityListInteractorOutput {
    func weatherFetched() {
        
    }
}
