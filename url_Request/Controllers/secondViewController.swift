//
//  SecondViewController.swift
//  TaskA
//
//  Created by SaifUllah Butt on 24/05/2021.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var appNameField: UITextField!
    @IBOutlet weak var appIdField: UITextField!
    @IBOutlet weak var appBundleId: UITextField!
    
    @IBOutlet weak var iosPlatform: UIButton!
    @IBOutlet weak var webPlatform: UIButton!
    @IBOutlet weak var androidPlatform: UIButton!
  
    var platform:[String] = ["ios"]
//    var platform = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleFieldAndButtons()
        iosPlatform.isSelected = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));        view.addGestureRecognizer(tap)
        
        
        }
    
    //MARK:- Mehotds
    
    //MARK:- Keyboard return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
       
       @objc func dismissKeyboard() {
           //Causes the view (or one of its embedded text fields) to resign the first responder status.
           view.endEditing(true)
       }
    
    func styleFieldAndButtons(){
        appNameField.roundCorners(radius: 5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        
        appBundleId.roundCorners(radius: 5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        
        appIdField.roundCorners(radius: 5, bordorColor: UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1), borderWidth: 1)
        
        
    }
    
    func addApp(param: [String:Any]) {
        UserHandler.addApp(param: param) { [self] (successResponse) in
            
            let alert = Constants.showAlert(message: successResponse.message)
            self.present(alert, animated: true, completion: nil)
            
        } failure: { (error) in
            let alert = Constants.showAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    //MARK:-IBActions
    @IBAction func checkUncheckBtns(_ sender: UIButton) {
        if sender.tag == 1{
            if iosPlatform.isSelected == true{
                iosPlatform.isSelected = false
                let modifiedArray = platform.filter { $0 != "ios" }
               self.platform = modifiedArray
                print(platform)
            }
            else{
                iosPlatform.isSelected = true
                self.platform.append("ios")
                print(platform)
            }
            
        }
        else if sender.tag == 2{
            if webPlatform.isSelected == true{
                webPlatform.isSelected = false
                let modifiedArray = platform.filter { $0 != "web" }
                self.platform = modifiedArray
                print(platform)

            }
            else{
                webPlatform.isSelected = true
                self.platform.append("web")
                print(platform)
            }
            
        }
        else if sender.tag == 3{
            if androidPlatform.isSelected == true{
                androidPlatform.isSelected = false
//                self.platform.remove(at: 2)
                let modifiedArray = platform.filter { $0 != "android" }
                self.platform = modifiedArray
                print(platform)
            }
            else{
                androidPlatform.isSelected = true
//                self.platform.insert("android", at: 2)
                self.platform.append("android")
                print(platform)
            }
            
        }
    }
    
    @IBAction func printBtn(_ sender: Any) {
        print("print")
        if appIdField.text == "" || appIdField.text == "" || appNameField.text == "" || platform == []{
            let alert = Constants.showAlert(message: "Please Fill all fields and mark atleat one box")
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let params : [String : AnyObject] = ["app_name": appNameField.text as AnyObject, "app_id": appIdField.text as AnyObject, "app_bundle_id": appBundleId.text as AnyObject, "platform": self.platform as AnyObject]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        print(data)
            addApp(param: data)
        }
    }
    
}
