//
//  CityDetailInteractor.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 24.09.2024.
//

import Foundation

class CityDetailInteractorImpl: CityDetailInteractorInput {
    // MARK: - Dependencies
    weak var output: CityDetailInteractorOutput?
    var imageDownloader: ImageDownloader? 
    
    // MARK: - Functions 
    func downloadImage(with iconName: String, for index: Int, in viewType: CityDetailImageInViewType) {
        Task {
            do {
                if let image = try await imageDownloader?.downloadImage(with: iconName) {
                    output?.imageDownloaded(with: image, for: index, in: viewType)
                }
            } catch {
                print(error)
            }
        }
    }
}
