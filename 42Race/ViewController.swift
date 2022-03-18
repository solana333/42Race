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

    var viewModel: BusinessViewModel = BusinessViewModel()
    lazy var loadingView: LoadingView = LoadingView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.register(UINib(nibName: "BusinessTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessTableViewCell")
    }

    @IBAction func searchAction() {
        guard let text = searchTextField.text else {
            return
        }
        viewModel.searchBusiness(text: text)
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
}

extension ViewController: BusinessViewModelDelegate {
    func errorDidOccur() {
        if let viewWithTag = self.view.viewWithTag(tagLoading) {
            viewWithTag.removeFromSuperview()
        }
    }
    func didStartLoading() {
        self.loadingView.tag = tagLoading
        self.view.addSubview(self.loadingView)
    }

    func itemsLoaded() {
        if let viewWithTag = self.view.viewWithTag(tagLoading) {
            viewWithTag.removeFromSuperview()
        }
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.business.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
        cell.bindData(data: self.viewModel.business[indexPath.row])
        return cell
    }
}
