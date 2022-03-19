//
//  ViewController.swift
//  42Race
//
//  Created by Phuoc on 3/15/22.
//

import UIKit

let tagLoading: Int = 999999
class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var errorLabel: UILabel!

    var viewModel: BusinessViewModel = BusinessViewModel(RequestManager.shared)
    lazy var loadingView: LoadingView = LoadingView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
    // Handle delay search text filed
    var searchTimer: Timer?
    let searchDelay = 0.5


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        viewModel.delegate = self
        messageView.isHidden = true
        searchTextField.addTarget(self, action: #selector(searchTextDidChange), for: .editingChanged)
        tableView.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
        tableView.register(UINib(nibName: "NoResultTableViewCell", bundle: nil), forCellReuseIdentifier: "NoResultTableViewCell")
    }

    @IBAction func sortAction() {
        let sortVC = SortViewController()
        sortVC.modalTransitionStyle = .crossDissolve
        sortVC.modalPresentationStyle = .overFullScreen
        sortVC.sortType = viewModel.sortType
        sortVC.sortByHandler = { [weak self] type in
            guard let self = self else { return }
            self.viewModel.sortBusinessBy(type: type)
        }
        self.present(sortVC, animated: true, completion: nil)
    }

    @objc func searchTextDidChange() {
        handleSearch()
    }

    func handleSearch() {
        if let searchTimer = searchTimer, searchTimer.isValid {
            searchTimer.invalidate()
        }
        searchTimer = Timer.scheduledTimer(timeInterval: searchDelay, target: self, selector: #selector(searchBusiness), userInfo: nil, repeats: false)
    }

    @objc func searchBusiness() {
        guard let text = searchTextField.text else {
            return
        }
        if !text.isEmpty {
            viewModel.searchBusiness(text: text)
        } else {
            viewModel.resetBusiness()
        }
    }
}

extension ViewController: BusinessViewModelDelegate {
    func errorDidOccur(error: Error) {
        if let viewWithTag = self.view.viewWithTag(tagLoading) {
            viewWithTag.removeFromSuperview()
        }
        self.errorLabel.text = error.localizedDescription
        self.messageView.isHidden = false
    }
    func didStartLoading() {
        self.loadingView.tag = tagLoading
        self.view.addSubview(self.loadingView)
    }

    func itemsLoaded() {
        if let viewWithTag = self.view.viewWithTag(tagLoading) {
            viewWithTag.removeFromSuperview()
        }
        self.messageView.isHidden = true
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.business.isEmpty {
            return 1
        }
        return viewModel.business.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.business.isEmpty {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NoResultTableViewCell", for: indexPath)
            return cell
        } else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
            cell.bindData(data: self.viewModel.business[indexPath.row])
            return cell
        }
    }
}
