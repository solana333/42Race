//
//  MonitorBusinessViewModelDelegate.swift
//  42RaceTests
//
//  Created by Dev on 3/18/22.
//

import Foundation

public class MonitorBusinessViewModelDelegate : BusinessViewModelDelegate {

    public var errorDidOccurCallback: ((Error) -> Void)?
    public var didStartLoadingCallback: (() -> Void)?
    public var itemsLoadedCallback: (() -> Void)?

    func errorDidOccur(error: Error) {
        errorDidOccurCallback?(error)
    }

    func didStartLoading() {
        didStartLoadingCallback?()
    }

    func itemsLoaded() {
        itemsLoadedCallback?()
    }
}
