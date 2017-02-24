//
//  LoadViewController.swift
//  DixHeures
//
//  Created by Luc CASIMIR on 2/22/17.
//  Copyright © 2017 Luc CASIMIR. All rights reserved.
//

import UIKit

class LoadViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    {
        didSet{
            textField.delegate = self
        }
    }
    
    let api = DeezerAPI.Shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dvc = segue.destination
        if let tabcon = dvc as? UITabBarController {
            dvc = (tabcon.viewControllers?[0])!
        }
        if let identifier = segue.identifier,
            let pl = sender as? [Playlist],
            let dest = dvc as? CollectionViewController{
            switch identifier {
            case "segue":
                dest.data = pl
            default:
                break
            }
        }
    }
}

extension LoadViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        api.requestUrl(String: textField.text!){
            playlist in
            self.performSegue(withIdentifier: "segue", sender: playlist)
        }
        return true
    }
}
