//
//  getDetailViewController.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class getDetailViewController: UIViewController {
    
    //MARK:- IBoutlet
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: GetDetailCell.className, bundle: nil), forCellReuseIdentifier: GetDetailCell.className)
        }
    }
    
    
    
    
    //MARK:- Propeties
    var dataArray = [DetailAppData]()
    var name = ""
    var appId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

//        appName.text = name
        print("app id is......... \(appId)")
        
        let params : [String : AnyObject] = ["app_id": appId as AnyObject]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        getDetail(param: data)
    }
    
    
    //MARK:- Methods
    func getDetail(param: [String:Any]) {
        UserHandler.getDetail(param: param) { [self] (successResponse) in
            if successResponse.message == "Success"{
                self.dataArray = successResponse.data
                print("found....")
                self.dataArray = successResponse.data
                self.tableView.reloadData()
            } else {
                let alert = Constants.showAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        } failure: { (error) in
            let alert = Constants.showAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}


//MARK:- Extensions
extension getDetailViewController : UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataArray.count
}
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GetDetailCell.className, for: indexPath) as! GetDetailCell
  
    let objData = dataArray[indexPath.row]

    if let platform = objData.platform {
        cell.platform.text = platform
    }
    if let environment = objData.environment {
        cell.environment.text = environment
    }
    if let buildNo = objData.buildNo {
        cell.buildNo.text = buildNo
    }
    return cell
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
}
}

