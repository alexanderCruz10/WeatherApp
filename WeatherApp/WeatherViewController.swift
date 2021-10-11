//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Cruz on 2021-10-02.
//

import UIKit
import SkeletonView

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAnimation()
        fetchWeather(byCity: "toronto")
    }
    
    private func fetchWeather(byCity city: String) {

        weatherManager.fetchWeather(byCity: city) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let weatherData):
                this.updateView(with: weatherData)
            case .failure(let error):
                print("Error here: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateView(with data: WeatherData) {
        hideAnimation()
        temperatureLabel.text = data.main.temp.toString().appending("°C")
        conditionLabel.text = data.weather.first?.description
        navigationItem.title = data.name
    }
    
    private func showAnimation(){
        conditionImageView.showAnimatedGradientSkeleton()
        temperatureLabel.showAnimatedGradientSkeleton()
        conditionLabel.showAnimatedGradientSkeleton()
    }
    
    private func hideAnimation() {
        conditionImageView.hideSkeleton()
        temperatureLabel.hideSkeleton()
        conditionLabel.hideSkeleton()
    }
    @IBAction func addLocationDidTapped(_ sender: Any) {
        
    }
    
    @IBAction func locationDidTapped(_ sender: Any) {
        
    }

}

