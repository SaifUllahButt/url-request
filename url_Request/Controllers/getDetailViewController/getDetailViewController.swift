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
    
    @IBOutlet weak var checkVersionOutlet: UIButton!
    @IBOutlet weak var updateVersionOutlet: UIButton!
    
    //MARK:- Propeties
    var dataArray = [DetailAppData]()
    var name = ""
    var appId = ""
    var environment = ""

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barTintColor = UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1)
        setButtonStyle()
        
//        appName.text = name
        print("app id is......... \(appId)")
        
        let params : [String : AnyObject] = ["app_id": appId as AnyObject]
        let data : [String : AnyObject] = ["data": params as AnyObject]
        getDetail(param: data)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    
    //MARK:- Methods
    
    func setButtonStyle(){
        checkVersionOutlet.layer.borderColor = UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1).cgColor
        checkVersionOutlet.layer.cornerRadius = checkVersionOutlet.frame.size.height/2.5
        checkVersionOutlet.layer.borderWidth = 1
        checkVersionOutlet.clipsToBounds = true
        updateVersionOutlet.layer.borderColor = UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1).cgColor
        updateVersionOutlet.layer.cornerRadius = updateVersionOutlet.frame.size.height/2.5
        updateVersionOutlet.layer.borderWidth = 1
        updateVersionOutlet.clipsToBounds = true
    }
    
    @objc func pullToRefresh(){
        print("refreshing start")
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            let params : [String : AnyObject] = ["app_id": self.appId as AnyObject]
            let data : [String : AnyObject] = ["data": params as AnyObject]
            self.getDetail(param: data)
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
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
    
    //MARK:-IBActions
    @IBAction func checkVersionBtn(_ sender: Any) {
        print("check version")
        let vc = storyboard?.instantiateViewController(identifier: "CheckVersionViewController")as! CheckVersionViewController
        vc.appId = appId
        vc.environment = environment
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func updateVersionBtn(_ sender: Any) {
        print("update version")
        let vc = storyboard?.instantiateViewController(identifier: "UpdateVersionViewController")as! UpdateVersionViewController
        vc.appId = appId
        vc.environment = environment
        navigationController?.pushViewController(vc, animated: true)
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
        self.environment = environment
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

