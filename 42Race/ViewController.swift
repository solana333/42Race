//
//  ViewController.swift
//  42Race
//
//  Created by Phuoc on 3/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchAction() {
        RequestManager.getBusinesses()
    }


}

