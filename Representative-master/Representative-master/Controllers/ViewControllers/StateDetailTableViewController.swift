//
//  StateDetailTableViewController.swift
//  Representative-master
//
//  Created by Austin Goetz on 10/2/19.
//  Copyright © 2019 DevMtnStudent. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {

    // Computed property
    var representatives: [Representative] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var state: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        title = state
        if let state = state {
            RepresentativeController.searchRepresentatives(forState: state) { (repArray) in
                self.representatives = repArray
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return representatives.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailVCCell", for: indexPath) as?
        RepresentativeTableViewCell else {return UITableViewCell() }
        
        cell.representative = representatives[indexPath.row]

        return cell
    }
}
