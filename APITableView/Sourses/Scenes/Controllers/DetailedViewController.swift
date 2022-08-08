//
//  DetailedViewController.swift
//  APITableView
//
//  Created by Мария Вольвакова on 05.08.2022.
//

import UIKit
import Alamofire

class DetailedViewController: UIViewController {
    
    var card: Card?
    
    @IBOutlet weak var cmc: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var rarity: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var manaCost: UILabel!
    @IBOutlet weak var textInCard: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorDetailed: UIActivityIndicatorView!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorDetailed.startAnimating()
        activityIndicatorDetailed.isHidden = false
        
        name.text = "\(String(describing: card?.name ?? "No data"))".uppercased()
        type.text = "Card type: \(String(describing: card?.type ?? "No data"))"
        manaCost.text = "Mana cost: \(String(describing: card?.manaCost ?? "No data"))"
        setName.text = "Set name: \(String(describing: card?.setName ?? "No data"))"
        cmc.text = "CMC: \(String(describing: card?.cmc ?? 0))"
        rarity.text = "Rarity: \(String(describing: card?.rarity ?? "No data"))"
        artist.text = "Artist: \(String(describing: card?.artist ?? "No data"))"
        textInCard.text = "Text: \(String(describing: card?.text ?? "No data"))"
        
        guard let pic = card?.imageUrl else {
            activityIndicatorDetailed.stopAnimating()
            activityIndicatorDetailed.isHidden = true
            imageLabel.text = "No card picture"
            return
        }
        makeRequestUrl(urlRequest: pic)
    }
}



