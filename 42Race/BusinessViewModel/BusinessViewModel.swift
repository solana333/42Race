//
//  BusinessViewModel.swift
//  42Race
//
//  Created by Dev on 3/17/22.
//

import Foundation


protocol BusinessViewModelDelegate {
    func errorDidOccur ()
    func didStartLoading ()
    func itemsLoaded()
}

enum Message : String {
    case error = "error. Please try again !"
}



class BusinessViewModel {

    var delegate: BusinessViewModelDelegate?
    var service = RequestManager.shared

    var business: [BusinessModel] = []

    func searchBusiness(text: String) {
        delegate?.didStartLoading()
        service.searchBusiness(text: text) { [weak self] data in
            guard let self = self else {

                return
            }
            self.business = data
            self.delegate?.itemsLoaded()
        }
    }
}
