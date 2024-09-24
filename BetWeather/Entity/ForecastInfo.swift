//
//  ForecastInfo.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecastInfo = try? JSONDecoder().decode(ForecastInfo.self, from: jsonData)

import Foundation

// MARK: - ForecastInfo
struct ForecastInfo: Codable {
    let now: Int?
    let nowDt: String?
    let info: Info?
    let fact: Fact?
    let forecasts: [Forecast]?

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case info, fact, forecasts
    }
}

// MARK: - Fact
struct Fact: Codable {
    let daytime: Daytime?
//    let obsTime: Int?
    let season, factSource: String?
//    let uptime: Int?
//    let cloudness: Double?
    let condition: FactCondition?
    let feelsLike, humidity: Int?
    let icon: String?
    let isThunder, polar: Bool?
//    let precProb: Int?
//    let precStrength: Double?
    let temp: Int?
//    let uvIndex, tempWater, windAngle: Int?
//    let windDir: WindDir?
//    let windGust, windSpeed: Double?
//    let source: String?
//    let biomet: Biomet?
//    let freshSnowMm: Int?
//    let precMm: Double?
    let tempMin, tempAvg, tempMax: Int?

    enum CodingKeys: String, CodingKey {
        case daytime
        case season
        case factSource = "source"
        case condition
        case feelsLike = "feels_like"
        case humidity, icon
        case isThunder = "is_thunder"
        case polar

        case temp
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
    }
}

// MARK: - Biomet
struct Biomet: Codable {
    let index: Int?
    let condition: BiometCondition?
}

enum BiometCondition: String, Codable {
    case magneticField0 = "magnetic-field_0"
}

enum FactCondition: String, Codable {
    case clear = "clear"
    case partlyCloudy = "partly-cloudy"
    case cloudy = "cloudy"
    case overcast = "overcast"
    case light = "light-rain"
    case rain = "rain"
    case heavyRain = "heavy-rain"
    case showers = "showers"
    case wetSnow = "wet-snow"
    case lightSnow = "light-snow"
    case snow = "snow"
    case snowShowers = "snow-showers"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case thunderstormWithRain = "thunderstorm-with-rain"
    case thunderstormWithHail = "thunderstorm-with-hail"
}

enum Daytime: String, Codable {
    case d = "d"
    case n = "n"
}

enum WindDir: String, Codable {
    case e = "e"
    case nw = "nw"
    case s = "s"
    case se = "se"
    case sw = "sw"
    case w = "w"
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String?
    let dateTs, week: Int?
    let sunrise, sunset, riseBegin, setEnd: String?
    let moonCode: Int?
    let moonText: String?
    let parts: Parts?
    let hours: [Hour]?

    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case week, sunrise, sunset
        case riseBegin = "rise_begin"
        case setEnd = "set_end"
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case parts, hours
    }
}

// MARK: - Hour
struct Hour: Codable {
    let hour: String?
    let condition: FactCondition?
    let feelsLike, humidity: Int?
    let icon: String?
    let temp: Int?


    enum CodingKeys: String, CodingKey {
        case hour
        case condition
        case feelsLike = "feels_like"
        case humidity
        case icon
        case temp
    }
}

// MARK: - Parts
struct Parts: Codable {
    let day: Day?
    let dayShort, evening, morning, night: Fact?
    let nightShort: Fact?

    enum CodingKeys: String, CodingKey {
        case day
        case dayShort = "day_short"
        case evening, morning, night
        case nightShort = "night_short"
    }
}

// MARK: - Day
struct Day: Codable {
    let daytime: Daytime?
    let source: String?
    let humidity: Int?
    let condition: FactCondition?
    let icon: String?
    let polar: Bool?
    let tempAvg: Int?
    let tempMax, tempMin, tempWater, feelsLike: Int?

    enum CodingKeys: String, CodingKey {
        case daytime
        case source = "_source"
        case condition
        case icon, polar
        case humidity
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case tempWater = "temp_water"
        case feelsLike = "feels_like"
    }
}

// MARK: - Info
struct Info: Codable {
    let lat, lon: Double?
    let tzinfo: Tzinfo?

    enum CodingKeys: String, CodingKey {
        case lat, lon, tzinfo

    }
}

// MARK: - Tzinfo
struct Tzinfo: Codable {
    let name, abbr: String?
}
