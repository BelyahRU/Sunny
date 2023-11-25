//
//  ViewController+alertController.swift
//  Sunny(API)
//
//  Created by Александр Андреев on 22.11.2023.
//

import Foundation
import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping(String) -> Void) {
        
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                //при вводе города может возникнуть ошибка, поэтому:
                //%20 это и есть пробел
                let city = cityName.split(separator: " ").joined(separator: "%20")
                
                
                //так можно сделать
                //self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
                
                //через клоужеры:
                completionHandler(city)
                
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
