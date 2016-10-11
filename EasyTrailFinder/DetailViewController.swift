//
//  DetailViewController.swift
//  EasyTrailFinder
//
//  Created by Jon Thornburg on 10/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var trail: Trail?
    let sorter = PropertSorter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "DetailCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "DetailCell")
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        print(trail?.actArray?.count)
    }
    
    // Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (trail?.actArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
        if trail?.actArray != nil {
            let trailImage = sorter.getThumbnail(trail: trail!, ind: indexPath.row)
            print(trailImage)
            if let trailImag = trailImage {
                cell.picture.downloadImageFrom(urlString: trailImag, completion: { 
                    cell.picture.contentMode = UIViewContentMode.scaleAspectFit
                    if trailImage == nil {
                        cell.picture.contentMode = UIViewContentMode.scaleAspectFit
                        cell.picture.image = UIImage(named: "placeholder")
                    }
                })
            } else {
                cell.picture.image = UIImage(named: "placeholder")
            }
            cell.usesLabel.text = sorter.getActivities(trail: trail!, ind: indexPath.row)
            cell.nameLabel.text = trail!.name
            cell.descriptionLabel.text = sorter.getDescription(trail: trail!, ind: indexPath.row)
        }
        return cell
    }
}
