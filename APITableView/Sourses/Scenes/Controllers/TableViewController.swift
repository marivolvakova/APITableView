//
//  ViewController.swift
//  APITableView
//
//  Created by Мария Вольвакова on 04.08.2022.
//

import UIKit
import Alamofire

class TableViewController: UIViewController {
    
    var cards = [Card]()
    var filteredArray = [Card]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableActivityIndicator: UIActivityIndicatorView!
    
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






