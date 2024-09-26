//
//  BaseNetworkService.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation

class BaseNetworkService<Router: URLRequestConvertible> {
    // MARK: - Private properties
    private let urlSession: URLSession
    
    // MARK: - Inits
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: - Functions
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    /// Делает асинхронный запрос в сеть
    /// - Parameters:
    ///   - returnType: Тип данных в которых будет распарсен запрос и который будет возвращен
    ///   - router: куда будет делаться запрос
    func request<T: Decodable>(_ returnType: T.Type, router: Router) async throws -> T {
        let request = try router.makeURLRequest()
        
        let (data, response) = try await urlSession.data(for: request)
        try handleResponse(data: data, response: response)
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(returnType, from: data)
            return decodedData
        } catch {
            print(error)
            throw NetworkError.decodingFailed
        }
    }
}
