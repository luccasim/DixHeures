//
//  TrackCell.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/24/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(WithTrack t: Track)
    {
        nameLabel.text = t.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
