//
//  LoadingView.swift
//  42Race
//
//  Created by Dev on 3/18/22.
//

import UIKit

final class LoadingView: UIView {

    fileprivate let spinner = UIActivityIndicatorView(style: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        spinner.transform = CGAffineTransform(scaleX: 2.75, y: 2.75);
        spinner.startAnimating()
        addSubview(spinner)
        backgroundColor = UIColor.clear
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.center = center
    }
}

