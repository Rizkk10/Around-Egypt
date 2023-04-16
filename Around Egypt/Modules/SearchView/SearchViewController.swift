//
//  SearchViewController.swift
//  Around Egypt
//
//  Created by Rezk on 14/04/2023.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var name : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = name
    }
    

}
