//
//  GeocodingResponse.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 26.09.2024.
//

import Foundation

// MARK: - GeocodingResponse
struct GeocodingResponse: Codable {
    let features: [Feature]?
}

// MARK: - Feature
struct Feature: Codable {
    let properties: Properties?
}


// MARK: - Properties
struct Properties: Codable {
    let country: String?
    let city: String?
    let lon, lat: Double?
}
