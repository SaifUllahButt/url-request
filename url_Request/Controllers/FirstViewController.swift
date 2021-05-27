//
//  FirstViewController.swift
//  TaskA
//
//  Created by SaifUllah Butt on 24/05/2021.
//

import UIKit

class FirstViewController: UIViewController {
    
    //MARK:-Iboutlets
    
    @IBOutlet weak var addAppOutlet: UIButton!
    
    @IBOutlet weak var addVersionOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    @IBAction func addAppBtn(_ sender: UIButton) {
     
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController")as! SecondViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func versionCheckBtn(_ sender: UIButton) {
        
        let s = storyboard?.instantiateViewController(identifier: "VersionCheckVC")as! VersionCheckVC
        navigationController?.pushViewController(s, animated: true)
    }
    
    

}
