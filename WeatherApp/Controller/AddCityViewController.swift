//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Alex Cruz on 2021-10-14.
//

import UIKit

class AddCityViewController: UIViewController {
    
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    private let weatherManager = WeatherManager()
    weak var delegate: WeatherViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cityTextField.becomeFirstResponder()
    }
    
    @IBAction func searchButtonDidTapped(_ sender: Any) {
        statusLabel.isHidden = true
        guard let query = cityTextField.text, !query.isEmpty else {
            showSearchError(text: "City cannot be empty. Please try again!")
            return }
        handleSearch(query: query)
    }
    
    private func setupView(){
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func showSearchError(text: String) {
        statusLabel.isHidden = false
        statusLabel.textColor = .systemRed
        statusLabel.text = text
    }
    private func handleSearch(query: String) {
        view.endEditing(true)
        activityIndicatorView.startAnimating()
        weatherManager.fetchWeather(byCity: query) { [weak self] (result) in
            guard let this = self else { return }
            this.activityIndicatorView.stopAnimating()
            switch result {
            case .success(let model):
                this.handleSearchSuccess(model: model)
            case .failure(let error):
                this.showSearchError(text: error.localizedDescription)
            }
        }
    }
    
    private func handleSearchSuccess(model: WeatherModel) {
        statusLabel.isHidden = false
        statusLabel.textColor = .systemGreen
        statusLabel.text = "Success!"
        delegate?.didUpdateWeatherFromSearch(model: model)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.delegate?.didUpdateWeatherFromSearch(model: model)
        }
   }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddCityViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}

