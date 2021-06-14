//
//  FirstViewController.swift
//  TaskA
//
//  Created by SaifUllah Butt on 24/05/2021.
//

import UIKit

class FirstViewController: UIViewController {
    // MARK:- Iboutlets
    @IBOutlet weak var addAppOutlet: UIButton!
    
    @IBOutlet weak var addVersionOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Apps version management system"
        navigationItem.title = "Version Control system"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(red: 102/255, green: 39/255, blue: 26/225, alpha: 1)
    }
    
    //MARK:-IBActions
    @IBAction func addAppBtn(_ sender: UIButton) {
     
         let vcc = storyboard?.instantiateViewController(identifier: "SecondViewController")as! SecondViewController // swiftlint:disable:this force_cast
        navigationController?.pushViewController(vcc, animated: true)
    }
//    @IBAction func versionCheckBtn(_ sender: UIButton) {
//
//        let s = storyboard?.instantiateViewController(identifier: "VersionCheckVC")as! VersionCheckVC
//        navigationController?.pushViewController(s, animated: true)
//    }
    @IBAction func allAppsBtn(_ sender: Any) {
        let sss = storyboard?.instantiateViewController(identifier: "getAllAppsViewController")as! getAllAppsViewController // swiftlint:disable:this force_cast
        navigationController?.pushViewController(sss, animated: true)
    }
}
