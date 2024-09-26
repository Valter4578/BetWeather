//
//  NetworkRepository.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

protocol NetworkRepository {
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo
    func fetchCityCoordinates(with cityName: String) async throws -> GeocodingResponse
}

class NetworkRepositoryImpl: NetworkRepository {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo {
        return try await networkService.fetchWeather(coordinates: coordinates)
    }
    
    func fetchCityCoordinates(with cityName: String) async throws -> GeocodingResponse {
        return try await networkService.fetchCityCoordinates(with: cityName)
    }
}
