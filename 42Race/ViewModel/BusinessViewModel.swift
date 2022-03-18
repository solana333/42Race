//
//  BusinessViewModel.swift
//  42Race
//
//  Created by Dev on 3/17/22.
//

import Foundation


protocol BusinessViewModelDelegate {
    func errorDidOccur (error: Error)
    func didStartLoading ()
    func itemsLoaded()
}

enum Message : String {
    case error = "error. Please try again !"
}

class BusinessViewModel {

    var delegate: BusinessViewModelDelegate?
    var service: RequestProtocol?
    var business: [BusinessModel] = []
    var error: Error?
    var sortType: SortType = .rating

    var showError: Bool = true
    var showLoading: Bool = false
    

    init (_ service: RequestProtocol) {
        self.service = service
    }

    func searchBusiness(text: String) {
        delegate?.didStartLoading()
        service?.searchBusiness(text: text) { [weak self] data, error in
            guard let self = self else {
                return
            }
            if self.sortType == .rating {
                self.business = data.sorted(by: { $0.rating > $1.rating })
            } else {
                self.business = data.sorted(by: { $0.distance > $1.distance })
            }
            if let error = error {
                self.delegate?.errorDidOccur(error: error)
            } else {
                self.delegate?.itemsLoaded()
            }
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
