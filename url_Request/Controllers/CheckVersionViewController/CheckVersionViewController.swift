//
//  CheckVersionViewController.swift
//  url_Request
//
//  Created by M Zaryab on 25/05/2021.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class CheckVersionViewController: UIViewController {
    // MARK:-IBOutlet
   
    @IBOutlet weak var checkVersionOutletBtn: UIButton!
    @IBOutlet weak var versionNo: UITextField!
    @IBOutlet weak var platform: UITextField!
    @IBOutlet weak var buildNoOutlet: UITextField!
    //MARK:- Properties
    var appId = ""
    var environment = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleFieldAndButtons()
       
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));        view.addGestureRecognizer(tap)
        
        
        print("app id is .....\(appId)")
        print("environment is .....\(environment)")
        
    }
    
    //MARK:-Methods
    func styleFieldAndButtons(){
        checkVersionOutletBtn.roundCorners(radius: checkVersionOutletBtn.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        versionNoOutlet.roundCorners(radius: versionNoOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        platformOutlet.roundCorners(radius: platformOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        buildNoOutlet.roundCorners(radius: buildNoOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
    }
    //MARK:- Keyboard return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
       
       @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }

    func checkVersion(param: [String:Any]) {
        UserHandler.checkVersion(param: param) { [self] (successResponse) in
            if (successResponse.status as AnyObject) as? NSString == "1"{
                let alert = Constants.showAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                let alert = Constants.showAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        } failure: { (error) in
            let alert = Constants.showAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //MARK:-IBActions
    @IBAction func checkVersionBtn(_ sender: Any) {
        if versionNoOutlet.text == "" || platformOutlet.text == "" || buildNoOutlet.text == ""{
            let alert = Constants.showAlert(message: "Please Fill all fields")
            self.present(alert, animated: true, completion: nil)
        }
        else {
        let params: [String: AnyObject]=["platform": platform.text, "app_id": appId, "version_no": versionNo.text, "environment": environment, "build_no": buildNoOutlet.text]
        let data: [String: AnyObject] = ["data": params as AnyObject]
        print(data)
        checkVersion(param: data)
        }
    }
}
