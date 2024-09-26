//
//  ImageDownloader.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 26.09.2024.
//

import UIKit
import SVGKitSwift
import SVGKit

enum ImageError: Error {
    case invalidData
    case invalidURL
}

protocol ImageDownloader {
    func downloadImage(with name: String) async throws -> UIImage
}

class ImageDownloaderImpl: ImageDownloader {
    private let baseURL = "https://yastatic.net/weather/i/icons/funky/dark/"
    
    private let imageCache = ImageCache()
    
    /// Асинхронное закачивание и кэширование иконок с API Яндекса
    /// - Parameter name: имя иконки
    /// - Returns: UIImage иконки
    func downloadImage(with name: String) async throws -> UIImage {
        guard let url = URL(string: baseURL + name + ".svg") else { throw ImageError.invalidURL }
        if let cachedImage = imageCache.image(for: url) {
            return cachedImage
        }

        let data = try await downloadImageData(from: url)
        
        if url.pathExtension.lowercased() == "svg" {
            if let svgImage = SVGKImage(data: data)?.uiImage {
                imageCache.cacheImage(svgImage, for: url)
                return svgImage
            } else {
                throw ImageError.invalidData
            }
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageError.invalidData
        }

        imageCache.cacheImage(image, for: url)
        return image
    }
    
    private func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
