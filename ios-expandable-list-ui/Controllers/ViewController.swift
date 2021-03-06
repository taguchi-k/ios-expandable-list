//
//  ViewController.swift
//  ios-expandable-list-ui
//
//  Created by Kushida　Eiji on 2016/12/03.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView:ExpandableTableView!
    var items:[[Int]?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create data
        for i in 0 ..< Int(arc4random_uniform(100)) {
            items.append([])
            for j in 0 ..< Int(arc4random_uniform(100)) {
                items[i]!.append(j)
            }
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (!items.isEmpty) {
            if (self.tableView.sectionOpen != NSNotFound && section == self.tableView.sectionOpen) {
                return items[section]!.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = "section \((indexPath as NSIndexPath).section) row \((indexPath as NSIndexPath).row)"
        cell.textLabel?.backgroundColor = UIColor.clear
        return cell
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView(tableView: self.tableView, section: section)
        headerView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(100)) / 100.0,
                                             green: CGFloat(arc4random_uniform(100)) / 100.0,
                                             blue: CGFloat(arc4random_uniform(255)) / 100.0,
                                             alpha: 1)
        
        let label = UILabel(frame: headerView.frame)
        label.text = "Section \(section), touch here!"
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.white
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
