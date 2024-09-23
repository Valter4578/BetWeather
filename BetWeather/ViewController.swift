//
//  ViewController.swift
//  BetWeather
//
//  Created by Максим Алексеев  on 23.09.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            
            let repository = NetworkRepositoryImpl(networkService: NetworkService())
//            let forecast = try await repository.fetchWeather(coordinates: Coordinates(lat: 52.37125, lon: 4.89388))
//            print(forecast)
            
        }
    }
}

