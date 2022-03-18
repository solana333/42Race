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
        if let url = URL(string: data.imageUrl) {
            self.photoImageView.kf.setImage(with: url, placeholder: nil)
        }
    }
}
