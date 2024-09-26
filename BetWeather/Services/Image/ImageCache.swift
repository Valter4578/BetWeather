//
//  ImageCache.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 26.09.2024.
//

import UIKit

class ImageCache {
    private var cache: [URL: UIImage] = [:]

    func cacheImage(_ image: UIImage, for url: URL) {
        cache[url] = image
    }

    func image(for url: URL) -> UIImage? {
        return cache[url]
    }
}
