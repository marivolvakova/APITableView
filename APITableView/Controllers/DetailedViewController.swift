//
//  DetailedViewController.swift
//  APITableView
//
//  Created by Мария Вольвакова on 05.08.2022.
//

import UIKit


class DetailedViewController: ViewController {
    
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    
    var card: Card?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = "\(String(describing: card?.name ?? "No data"))".uppercased()
        //type.text = card?.type
    }
}
