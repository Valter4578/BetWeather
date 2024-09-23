//
//  CityListInteractor.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

class CityListInteractorImpl: CityListInteractorInput {    
    weak var output: CityListInteractorOutput?
    var networkRepository: NetworkRepository
    
    init(networkRepository: NetworkRepository) {
        self.networkRepository = networkRepository
    }
    
    func fetchWeather(for coordinates: Coordinates) {
        Task {
            let forecastInfo = try await networkRepository.fetchWeather(coordinates: coordinates)
            output?.weatherFetched(forecastInfo: forecastInfo)
        }
    }
}
