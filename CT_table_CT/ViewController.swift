//
//  ViewController.swift
//  CT_table_CT
//
//  Created by A on 12/7/17.
//  Copyright © 2017 Arena. All rights reserved.
//

import UIKit

//MARK: Data structures
struct Section {
    var name: String
    var items: [String]
    var collapsed: Bool
    
    init(name: String, items: [String], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}


class ViewController: UIViewController,CollapsibleTableViewHeaderDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    //MARK: [0]var
     @IBOutlet weak var collapisableTable: UITableView!
    var sections = [Section]()
    let headerCell = CollapsibleTableViewHeader(reuseIdentifier: "header")
    
    
    //MARK: [1]func
    //MARK: tables functions
    func numberOfSections(in tableView: UITableView) -> Int {
      return  sections.count
    }
   
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Reload the whole section
        collapisableTable.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    
}

    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell =   collapisableTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = sections[indexPath.section].items[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
  

    //MARK: view functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: configiration
        sections = [
            Section(name: "Mac", items: ["MacBook", "MacBook Air"]),
            Section(name: "iPad", items: ["iPad Pro", "iPad Air 2"]),
            Section(name: "iPhone", items: ["iPhone 7", "iPhone 6"])
        ]
        //MARK: delegation & datasources
        collapisableTable.dataSource = self
        collapisableTable.delegate = self
        // Auto resizing the height of the cell
        collapisableTable.estimatedRowHeight = 44.0
        collapisableTable.rowHeight = UITableViewAutomaticDimension
        
        
     
    }

    


}

