//
//  BusinessTableViewCell.swift
//  42Race
//
//  Created by Dev on 3/17/22.
//

import UIKit
import Kingfisher

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.photoImageView.layer.cornerRadius = 10
    }

    func bindData(data: BusinessModel) {
        self.nameLabel.text = data.name
        self.addressLabel.text = data.address.joined(separator: ", ")
        self.starLabel.text = "\(data.rating)"
        self.categoryLabel.text = data.getCategory()
        self.distanceLabel.text = String(format: "%.0f m", data.distance)
        if let url = URL(string: data.imageUrl) {
            self.photoImageView.kf.setImage(with: url, placeholder: nil)
        }
    }
}
