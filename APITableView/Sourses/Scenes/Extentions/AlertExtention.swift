//
//  AlertExtention.swift
//  APITableView
//
//  Created by Мария Вольвакова on 08.08.2022.
//

import UIKit


extension TableViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertButton)
        present(alert, animated: true, completion: nil)
    }
}


extension DetailedViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertButton)
        present(alert, animated: true, completion: nil)
    }
}
