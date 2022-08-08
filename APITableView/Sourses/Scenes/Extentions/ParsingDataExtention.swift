//
//  ParsingExtention.swift
//  APITableView
//
//  Created by Мария Вольвакова on 08.08.2022.
//

import UIKit
import Alamofire


extension TableViewController {
    func fetchCard() {
        if filteredArray.isEmpty {
            let request = AF.request("https://api.magicthegathering.io/v1/cards")
            request.responseDecodable(of: Cards.self) { [self] (data) in
            guard let cardData = data.value else {
                alert(title: "Error", message: "Data loading error")
                return
            }
            let cards = cardData.cards
            self.cards = cards
        
            tableView?.reloadData()
            
            tableActivityIndicator.stopAnimating()
            tableActivityIndicator?.isHidden = true
            }
        } else {
            let request = AF.request("https://api.magicthegathering.io/v1/cards")
            request.responseDecodable(of: Cards.self) { [self] (data) in
                guard let cardData = data.value else {
                    alert(title: "Error", message: "Data loading error")
                    return
                }
                let cards = cardData.cards
                self.filteredArray = cards
                
                tableView?.reloadData()
                
                tableActivityIndicator.stopAnimating()
                tableActivityIndicator?.isHidden = true
            }
        }
    }
}
