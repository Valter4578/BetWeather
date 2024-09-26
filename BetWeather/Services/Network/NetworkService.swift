//
//  NetworkService.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo
    func fetchCityCoordinates(with cityName: String) async throws -> GeocodingResponse
}

class NetworkService: BaseNetworkService<NetworkRouter>, NetworkServiceProtocol {
    func fetchCityCoordinates(with cityName: String) async throws -> GeocodingResponse {
        return try await request(GeocodingResponse.self, router: .coordinates(cityName: cityName))
    }
    
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo {
        return try await request(ForecastInfo.self, router: .forecast(coordinates: coordinates))
    }
}
