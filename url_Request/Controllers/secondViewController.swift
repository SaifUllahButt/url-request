//
//  secondViewController.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit
import Alamofire

class secondViewController: UIViewController {
    //MARK:- IBOutlets
    
    //MARK:- properties

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func getProfile(param: [String:Any]) {
        UserHandler.getProfile(param: param) { [self] (successResponse) in
            if successResponse.message == "Success"{
                let alert = Constants.showAlert(message: "pass")
                self.present(alert, animated: true, completion: nil)
            
            } else {
                let alert = Constants.showAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        } failure: { (error) in
            let alert = Constants.showAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }

    @IBAction func getDat(_ sender: Any) {
//
        let params : [String : AnyObject] = ["app_id": "parsl" as AnyObject]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        getProfile(param: data)
    }
    
}
