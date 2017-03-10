//
//  ItemListDataProvider.swift
//  TodoAppTDD
//
//  Created by Edgar Cardoso on 3/10/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import UIKit

enum Section: Int {
    case ToDo
    case Done
}

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var itemManager: ItemManager?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        guard let itemSection = Section(rawValue: section) else { fatalError() }
        
        let numberOfRows: Int
        
        switch(itemSection) {
        case .ToDo:
            numberOfRows = itemManager.todoCount
        case .Done:
            numberOfRows = itemManager.doneCount
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        guard let itemManager = itemManager else { fatalError() }
        guard let itemSection = Section(rawValue: indexPath.section) else { fatalError() }
        
        let item : TodoItem
        
        switch itemSection {
        case .ToDo:
            item = itemManager.item(at: indexPath.row)
        case .Done:
            item = itemManager.doneItem(at: indexPath.row)
        }
        
        cell.configCell(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        let buttonTitle: String
        
        switch section {
        case .ToDo:
            buttonTitle = "Check"
        default:
            buttonTitle = "Uncheck"
        }
        
        return buttonTitle
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let itemManager = itemManager else { fatalError() }
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        
        switch section {
        case .ToDo:
            itemManager.checkItem(at: indexPath.row)
        default:
            itemManager.uncheckItem(at: indexPath.row)
        }
        
        tableView.reloadData()
    }
}
