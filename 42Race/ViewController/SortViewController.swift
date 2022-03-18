//
//  SortViewController.swift
//  42Race
//
//  Created by Dev on 3/18/22.
//

import UIKit

enum SortType {
    case rating
    case distance
}

class SortViewController: UIViewController {

    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!

    var sortByHandler: ((_ type: SortType) -> ())?
    var sortType: SortType = .rating

    override func viewDidLoad() {
        setupView()
    }

    private func setupView() {
        if sortType == .rating {
            ratingButton.setTitleColor(.blue, for: .normal)
            distanceButton.setTitleColor(.black, for: .normal)
        } else {
            ratingButton.setTitleColor(.black, for: .normal)
            distanceButton.setTitleColor(.blue, for: .normal)
        }
    }

    @IBAction func dismisAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func distanceSortAction() {
        self.dismiss(animated: true)
        sortByHandler?(.distance)
    }

    @IBAction func ratingSortAction() {
        self.dismiss(animated: true)
        sortByHandler?(.rating)
    }
}
