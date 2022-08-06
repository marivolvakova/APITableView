//
//  ViewController.swift
//  APITableView
//
//  Created by Мария Вольвакова on 04.08.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicatorViewController: UIActivityIndicatorView!
    
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cards list"
        
        
        activityIndicatorViewController?.startAnimating()
        activityIndicatorViewController?.isHidden = false
        
        fetchCard()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = cards[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Subtitle2")
        cell.textLabel?.text = info.name
        cell.detailTextLabel?.text = info.type
        cell.accessoryType = .disclosureIndicator
        return cell
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


extension ViewController {
    func fetchCard() {
        let request = AF.request("https://api.magicthegathering.io/v1/cards")
        request.responseDecodable(of: Cards.self) { [self] (data) in
            guard let car = data.value else { return }
            let cards = car.cards
            self.cards = cards

            tableView?.reloadData()
            
            activityIndicatorViewController?.stopAnimating()
            activityIndicatorViewController?.isHidden = true
        }
    }
}
