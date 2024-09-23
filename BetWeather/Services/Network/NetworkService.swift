//
//  NetworkService.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo
}

class NetworkService: BaseNetworkService<NetworkRouter>, NetworkServiceProtocol {
    func fetchWeather(coordinates: Coordinates) async throws -> ForecastInfo {
        return try await request(ForecastInfo.self, router: .forecast(coordinates: coordinates))
    }
}
