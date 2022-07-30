//
//  ViewController.swift
//  NaviAssignment1
//
//  Created by Nancy Jain on 30/07/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = ClosedPRViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadClosedPullRequestData()
    }
    
    private func loadClosedPullRequestData() {
        viewModel.fetchClosedPR { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClosedPRTableViewCell", for: indexPath) as! ClosedPRTableViewCell
        let userDetails = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(userDetails)
        return cell
    }
    
    
}
