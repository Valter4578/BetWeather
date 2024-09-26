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
            await MainActor.run {
                output?.weatherFetched(forecastInfo: forecastInfo)
            }
        }
    }
    
    func fetchCityCoordinates(for city: String) {
        Task {
            let response = try await networkRepository.fetchCityCoordinates(for: city)
            guard let lat = response.features?[0].properties?.lat,
                  let lon = response.features?[0].properties?.lon
            else { return }
            
            let coordinates = Coordinates(lat: lat, lon: lon)
            await MainActor.run {
                output?.coordinatesFetched(coordinates: coordinates)
            }
        }
    }
    
    func getCityName(from coordinates: Coordinates) async -> String? {
        await Task {
            do {
                let response = try await self.networkRepository.fetchCityName(from: coordinates)
                guard let cityName = response.features?[0].properties?.city else { return nil }
                return cityName
                
            } catch {
                print(error)
                return nil
            }
        }.value
    }
}
