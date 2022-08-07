//
//  DetailedViewController.swift
//  APITableView
//
//  Created by Мария Вольвакова on 05.08.2022.
//

import UIKit
import Alamofire
import Kingfisher



class DetailedViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var manaCost: UILabel!
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var cmc: UILabel!
    @IBOutlet weak var rarity: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var textInCard: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var activityIndicatorDetailed: UIActivityIndicatorView!

    @IBOutlet weak var imageView: UIImageView!
    
    var card: Card?
    
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
        
        guard let url = URL(string: pic) else { return }
            
        downloadImage(from: url)
        

    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")

            DispatchQueue.main.async() { [weak self] in
                self?.imageView.image = UIImage(data: data)
                
                self?.activityIndicatorDetailed.stopAnimating()
                self?.activityIndicatorDetailed.isHidden = true
               
            }
        }
    }
    
}


