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
    
    init(output: CityListInteractorOutput?, networkRepository: NetworkRepository) {
        self.output = output
        self.networkRepository = networkRepository
    }
    
    func fetchWeather() {
        Task {
            try await networkRepository.fetchWeather(coordinates: Coordinates(lat: 52.37125, lon: 4.89388))
            output?.weatherFetched()
        }
    }
}
