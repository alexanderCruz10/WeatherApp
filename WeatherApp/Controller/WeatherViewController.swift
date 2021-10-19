//
//  ViewController.swift
//  WeatherApp
//
//  Created by Alex Cruz on 2021-10-02.
//

import UIKit
import SkeletonView

protocol WeatherViewControllerDelegate: class {
    func didUpdateWeatherFromSearch(model: WeatherModel)
}
class WeatherViewController: UIViewController {

    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    private let weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showAnimation()
        fetchWeather(byCity: "los angeles")
    }
    
    private func fetchWeather(byCity city: String) {

        weatherManager.fetchWeather(byCity: city) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(let model):
                this.updateView(with: model)
            case .failure(let error):
                print("Error here: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateView(with model: WeatherModel) {
        hideAnimation()
        temperatureLabel.text = model.temp.toString().appending("°C")
        conditionLabel.text = model.conditionDescription
        navigationItem.title = model.countryName
        conditionImageView.image = UIImage(named: model.conditionImage)
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
    @IBAction func addCityDidTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAddCity", sender: nil)
    }
    
    @IBAction func locationDidTapped(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddCity" {
            if let destination = segue.destination as? AddCityViewController {
                destination.delegate = self
            }
        }
    }

}

extension WeatherViewController: WeatherViewControllerDelegate {
    
    func didUpdateWeatherFromSearch(model: WeatherModel) {
    presentedViewController?.dismiss(animated: true, completion: { [weak self] in
    guard let this = self else { return }
      this.updateView(with: model)
      })
    }
}

