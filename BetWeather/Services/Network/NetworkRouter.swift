//
//  NetworkRouter.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

protocol URLRequestConvertible {
    func makeURLRequest() throws -> URLRequest
}

enum NetworkRouter: URLRequestConvertible {
    case forecast(coordinates: Coordinates)
    case coordinates(cityName: String)
    case cityName(coordinates: Coordinates)
    
    var endpoint: String {
        switch self {
        case .forecast(let coordinates):
            return "/forecast?lat=\(coordinates.lat)&lon=\(coordinates.lon)"
        case .coordinates(let cityName):
            return "search?text=\(cityName)&apiKey=\(APIConfig.geoapifyAPIKey)"
        case .cityName(let coordinates):
            return "reverse?lon=\(coordinates.lon)&lat=\(coordinates.lat)&apiKey=\(APIConfig.geoapifyAPIKey)"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    var baseURL: String {
        switch self {
        case .forecast( _):
            return APIConfig.baseYandexURL
        case .coordinates( _):
            return APIConfig.baseGeoapifyURL
        case .cityName( _):
            return APIConfig.baseGeoapifyURL
        }
    }
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        switch self {
        case .forecast(let coordinates):
            request.addValue(APIConfig.yandexAPIKey, forHTTPHeaderField: "X-Yandex-Weather-Key") // в продакшене ключ надо прятать в зашифрованном виде на сервер, но для тестового опустил этот момент
        default:
            break
        }
        
        return request
    }
}
