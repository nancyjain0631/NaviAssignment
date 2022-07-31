//
//  ViewController.swift
//  NaviAssignment1
//
//  Created by Nancy Jain on 30/07/22.
//

import UIKit

class ClosedPRViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = ClosedPRViewModel()
    private var apiServices = ApiServices()
    var userDetails = [UserDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadClosedPullRequestData()
    }

    private func loadClosedPullRequestData() {
        viewModel.fetchClosedPR { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }

}

extension ClosedPRViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestCell", for: indexPath) as! ClosedPRTableViewCell
        let userDetails = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(userDetails)
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            guard !apiServices.isPaginating else {
                //we are already fetching more data
                return
                
            }
            print("fetch")
            apiServices.getData(pagination: true) { [weak self] (result) in
                switch result {
                case .success(let moreData):
                    self?.userDetails.append(contentsOf: moreData)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }


}
