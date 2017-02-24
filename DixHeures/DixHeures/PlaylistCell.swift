//
//  PlaylistCell.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/23/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class PlaylistCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.image = #imageLiteral(resourceName: "link")
        }
    }
    @IBOutlet weak var OwnerLabel: UILabel!
    @IBOutlet weak var nbTracks: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(WithPlaylist pl:Playlist)
    {
        titleLabel.text = pl.title
        OwnerLabel.text = pl.creator
        nbTracks.text = String(pl.nbTrack)
        dateLabel.text = pl.date
        let qos = DispatchQoS.background.qosClass
        let queue = DispatchQueue.global(qos: qos)
        queue.async {
            if let url = URL.init(string: pl.urlImage) {
                do {
                    let data = try Data.init(contentsOf: url)
                    let img = UIImage.init(data: data)
                    DispatchQueue.main.async {
                        self.imageView.image = img
                    }
                }
                catch let err {
                    print(err)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
