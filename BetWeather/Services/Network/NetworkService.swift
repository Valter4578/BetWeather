//
//  NetworkService.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo
    func fetchCityCoordinates(for cityName: String) async throws -> GeocodingResponse
    func fetchCityName(from coordinates: Coordinates) async throws -> GeocodingResponse
}

class NetworkService: BaseNetworkService<NetworkRouter>, NetworkServiceProtocol {
    func fetchCityName(from coordinates: Coordinates) async throws -> GeocodingResponse {
        return try await request(GeocodingResponse.self, router: .cityName(coordinates: coordinates))
    }
    
    func fetchCityCoordinates(for cityName: String) async throws -> GeocodingResponse {
        return try await request(GeocodingResponse.self, router: .coordinates(cityName: cityName))
    }
    
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo {
        return try await request(ForecastInfo.self, router: .forecast(coordinates: coordinates))
    }
}
