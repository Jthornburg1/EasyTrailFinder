//
//  ViewController.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Trail]()
    let api = CallApi()
    var itemsIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "FirstTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "FirstCell")
        
        tableView.isHidden = true
        
        // tablecell layout
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.isHidden = true
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        self.title = "Easy Trails"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        tableView.isHidden = false
        api.getDataBySearchTerm(term: textField.text!) { (trails, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                self.items = trails!
                self.tableView.reloadData()
            }
        }
        return true
    }
    
    // TableView methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell") as! FirstTableViewCell
        if let name = items[indexPath.row].name {
            cell.nameLabel.text = name
        }
        if let loc = items[indexPath.row].city {
            if let st = items[indexPath.row].state {
                cell.locationLabel.text = "\(loc), \(st)"
            }
        }
        if let desc = items[indexPath.row].described1 {
            cell.descriptionLabel.text = desc
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemsIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.trail = items[itemsIndex!]
        vc.view.backgroundColor = UIColor.orange
    }
}

