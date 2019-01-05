//
//  TipsTableViewController.swift
//  Game-p5
//
//  Created by Beatriz Esteban on 22/11/2018.
//  Copyright © 2018 Beatriz Esteban. All rights reserved.
//

import UIKit

class TipsTableViewController: UITableViewController {

    var tips = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print(tips)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tips.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tips Cell", for: indexPath)

        let tips1 = tips[indexPath.row]
        cell.textLabel?.text = tips1

        return cell
    }
}
