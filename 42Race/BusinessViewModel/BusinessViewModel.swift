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
    var service: RequestProtocol = RequestManager.shared
    var business: [BusinessModel] = []
    var sortType: SortType = .rating

    func searchBusiness(text: String) {
        delegate?.didStartLoading()
        service.searchBusiness(text: text) { [weak self] data in
            guard let self = self else {
                return
            }
            if self.sortType == .rating {
                self.business = data.sorted(by: { $0.rating > $1.rating })
            } else {
                self.business = data.sorted(by: { $0.distance > $1.distance })
            }
            self.delegate?.itemsLoaded()
        }
    }

    func resetBusiness() {
        self.business = []
        self.delegate?.itemsLoaded()
    }

    func sortBusinessBy(type: SortType) {
        self.sortType = type
        if type == .rating {
            business = business.sorted(by: { $0.rating > $1.rating })
        }
        if type == .distance {
            business = business.sorted(by: { $0.distance > $1.distance })
        }
        self.delegate?.itemsLoaded()
    }
}
