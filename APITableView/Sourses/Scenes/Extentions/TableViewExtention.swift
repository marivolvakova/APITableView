//
//  TableViewExtention.swift
//  APITableView
//
//  Created by Мария Вольвакова on 08.08.2022.
//

import UIKit


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
                if filteredArray.isEmpty {
                    destination.card = cards[(tableView.indexPathForSelectedRow?.row)!]
                } else {
                    destination.card = filteredArray[(tableView.indexPathForSelectedRow?.row)!]
                }
        }
    }
}
