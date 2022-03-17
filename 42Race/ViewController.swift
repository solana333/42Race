//
//  ViewController.swift
//  42Race
//
//  Created by Phuoc on 3/15/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    var viewModel: BusinessViewModel = BusinessViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchAction() {
        guard let text = searchTextField.text else {
            return
        }
        viewModel.searchBusiness(text: text)
    }
}

extension ViewController: BusinessViewModelDelegate {
    func errorDidOccur(viewModel: BusinessViewModel) {

    }

    func didStartLoading(viewModel: BusinessViewModel) {

    }

    func itemsLoaded() {
        print(viewModel.business)
    }
}
