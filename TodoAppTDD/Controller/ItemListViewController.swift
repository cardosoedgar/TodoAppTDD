//
//  ItemListViewController.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/10/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: (UITableViewDelegate & UITableViewDataSource)!
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
    }
}
