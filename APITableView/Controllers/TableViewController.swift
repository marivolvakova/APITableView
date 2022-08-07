//
//  ViewController.swift
//  APITableView
//
//  Created by Мария Вольвакова on 04.08.2022.
//

import UIKit
import Alamofire

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tableActivityIndicator: UIActivityIndicatorView!
    
    
    var filteredArray = [Card]()
    
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cards research"
        
        tableActivityIndicator?.startAnimating()
        tableActivityIndicator?.isHidden = false

        fetchCard()
        
    }

    @IBAction func searchFunc(_ sender: Any) {
        filteredArray.removeAll()
        
        if textField.hasText {
            for card in cards {
                if card.name == textField.text {
                    filteredArray.append(card)
                    
                    tableView.reloadData()
                }
            }
        } else {
            tableView.reloadData()
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredArray.isEmpty {
            return cards.count
        } else {
            return filteredArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filteredArray.isEmpty {
            let info = cards[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle2")
            cell.textLabel?.text = info.name
            cell.detailTextLabel?.text = info.type
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
            let info = filteredArray[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle2")
            cell.textLabel?.text = info.name
            cell.detailTextLabel?.text = info.type
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailedViewController {
                destination.card = cards[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}


extension TableViewController {
    func fetchCard() {
        if filteredArray.isEmpty {
        let request = AF.request("https://api.magicthegathering.io/v1/cards")
        request.responseDecodable(of: Cards.self) { [self] (data) in
            guard let cardData = data.value else { return }
            let cards = cardData.cards
            self.cards = cards
        
            tableView?.reloadData()
            
            tableActivityIndicator.stopAnimating()
            tableActivityIndicator?.isHidden = true
        }
        } else {
            let request = AF.request("https://api.magicthegathering.io/v1/cards")
            request.responseDecodable(of: Cards.self) { [self] (data) in
                guard let cardData = data.value else { return }
                let cards = cardData.cards
                self.filteredArray = cards
                
                tableView?.reloadData()
                
                tableActivityIndicator.stopAnimating()
                tableActivityIndicator?.isHidden = true
            }
        }
        
    }
}
