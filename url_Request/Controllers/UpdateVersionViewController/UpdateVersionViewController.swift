//
//  UpdateVersionViewController.swift
//  url_Request
//
//  Created by M Zaryab on 25/05/2021.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class UpdateVersionViewController: UIViewController {
    //MARK:-IBoutlet
    @IBOutlet weak var versionOulet: UITextField!
    @IBOutlet weak var buildOutlet: UITextField!
    @IBOutlet weak var updateOutlet: UIButton!
    @IBOutlet weak var commentsOutlet: UITextField!
    
    @IBOutlet weak var iosBtn: UIButton!
    @IBOutlet weak var androidBtn: UIButton!
    
    //MARK:-Properties
    var appId = ""
    var environment = ""
    var platform = ""
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iosBtn.isSelected = true
        platform = "ios"
        styleFieldAndButtons()
       
     
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));        view.addGestureRecognizer(tap)
        
        print(appId)
        print(environment)
        print(platform)
    }
    //MARK:-Methods
    
     func styleFieldAndButtons(){
        versionOulet.roundCorners(radius: versionOulet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        buildOutlet.roundCorners(radius: buildOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        commentsOutlet.roundCorners(radius: commentsOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        updateOutlet.roundCorners(radius: updateOutlet.frame.size.height/2.5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
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

    func updateVersion(param: [String:Any]) {
        UserHandler.updateVersion(param: param) { [self] (successResponse) in
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
    
    @IBAction func checkButtons(_ sender: UIButton) {
        if sender.tag == 1{
            iosBtn.isSelected = true
            androidBtn.isSelected = false
            self.platform = "ios"
            print(platform)
        }
        else if sender.tag == 2  {
            androidBtn.isSelected = true
            iosBtn.isSelected = false
            self.platform = "android"
            print(platform)
        }
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        print("update ")
        print(platform)
        if versionOulet.text == "" || buildOutlet.text == "" || commentsOutlet.text == ""{
            let alert = Constants.showAlert(message: "Please Fill all fields")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let params : [String : AnyObject] = ["platform": platform as AnyObject, "app_id": appId as AnyObject, "version_no": versionOulet.text as AnyObject, "environment": environment as AnyObject, "build_no": buildOutlet.text as AnyObject, "comments": commentsOutlet.text as AnyObject  ]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        print(data)
        updateVersion(param: data)
        }
    }
    
}
