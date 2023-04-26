//
//  ParsingImage.swift
//  APITableView
//
//  Created by Мария Вольвакова on 08.08.2022.
//

import UIKit
import Alamofire

extension DetailedViewController {
    public func makeRequestUrl(urlRequest: String) {
        let urlRequest = URL(string: urlRequest)
        
        guard let url = urlRequest else  {
            alert(title: "Error", message: "Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                if (error as! URLError).code == URLError.notConnectedToInternet {
                    switch (error as! URLError).code {
                    case URLError.resourceUnavailable:
                        self.alert(title: "Error", message: "The resource is unavailable")
                    case URLError.badServerResponse:
                        self.alert(title: "Error", message: "No response from the server")
                    case URLError.networkConnectionLost:
                        self.alert(title: "Error", message: "Internet connection is not stable")
                    default:
                        self.alert(title: "Error", message: "Unknown error")
                    }
                }
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    self.alert(title: "Error", message: "Response status is \(response.statusCode)")
            }
                guard let data = data else {
                    self.alert(title: "Error", message: "No data")
                    return
                }
                DispatchQueue.main.async() { [weak self] in
                    self?.imageView.image = UIImage(data: data)
                    
                    self?.activityIndicatorDetailed.stopAnimating()
                    self?.activityIndicatorDetailed.isHidden = true
                }
            }
        }.resume()
    }
}
