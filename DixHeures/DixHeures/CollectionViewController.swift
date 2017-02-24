//
//  CollectionViewController.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/23/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    {
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: "PlaylistCell", bundle: nil), forCellWithReuseIdentifier: "playlistCell")
        }
    }
    
    var api = DeezerAPI.Shared{
        didSet{
            api.delegate = self
        }
    }
    var data : [Playlist]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier!
        
        if let dvc = segue.destination as? TableViewController {
            switch identifier {
            case "tableView":
                if let tracks = sender as? Playlist {
                    dvc.data = tracks.tracklist
                }
            default:
                break
            }
        }
    }
}

extension CollectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistCell", for: indexPath) as? PlaylistCell
        cell?.setup(WithPlaylist: data[indexPath.row])
        return cell!
    }
}

extension CollectionViewController : DeezerAPiDelegate{
    func tracklistLoad() {
    }
}

extension CollectionViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = data[indexPath.row]
        if api.availableTrack {
            performSegue(withIdentifier: "tableView", sender: playlist)
        }
    }
}

extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
