//
//  MenuViewController.swift
//  StoreSearch
//
//  Created by Permi on 2018/5/31.
//  Copyright © 2018 Permi. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate : class {
    func menuViewControllerSendEmail(_ controller: MenuViewController)
}

class MenuViewController: UITableViewController {

    weak var delegate: MenuViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            delegate?.menuViewControllerSendEmail(self)
        }
    }
}
