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
    
    var endpoint: String {
        switch self {
        case .forecast(let coordinates):
            return "/forecast?lat=\(coordinates.lat)&lon=\(coordinates.lon)"
        }
    }
    
    var method: String {
        switch self {
        case .forecast:
            return "GET"
        }
    }
    
    
    func makeURLRequest() throws -> URLRequest {
        guard let url = URL(string: APIConfig.baseURL + endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("29d57036-33f2-437d-8bfb-37dd73ff9019", forHTTPHeaderField: "X-Yandex-Weather-Key") // в продакшене ключ надо прятать в зашифрованном виде на сервер, но для тестового опустил этот момент

        return request
    }
}
