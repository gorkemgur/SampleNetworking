//
//  ViewController.swift
//  template
//
//  Created by Görkem Gür on 6.04.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await fetch()
        }
    }
    
    func fetch() async {
        do {
            let user = try await NetworkRoutes.registerUser()
            print(user)
        } catch {
            print("Error fetching user: \(error)")
        }
    }
}

