//
//  TableViewController.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/23/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib.init(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "TrackCell")
        }
    }
    
    var data : [Track]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TableViewController : UITableViewDelegate {
    
}

extension TableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as? TrackCell
        cell?.setup(WithTrack: data[indexPath.row])
        return cell!
    }
}
