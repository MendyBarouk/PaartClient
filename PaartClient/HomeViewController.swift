//
//  HomeViewController.swift
//  PaartClient
//
//  Created by Menahem Barouk on 24/10/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performSegue(withIdentifier: "toIntroSegue", sender: nil)
    }

}
