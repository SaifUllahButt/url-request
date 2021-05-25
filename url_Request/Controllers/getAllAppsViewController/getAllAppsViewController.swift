//
//  getAllAppsViewController.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class getAllAppsViewController: UIViewController {

    //MARK:-IBOutlets
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: AllAppsCell.className, bundle: nil), forCellReuseIdentifier: AllAppsCell.className)
        }
    }
    //MARK:- Properties
    var dataArray = [AllAppsData]()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data : [String : AnyObject] = [:]
        getAllApps(param: data)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(red: 47/255, green: 72/255, blue: 85/225, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
//MARK:- Methods
    @objc func pullToRefresh(){
        print("refreshing start")
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            let data : [String : AnyObject] = [:]
            self.getAllApps(param: data)
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func getAllApps(param: [String:Any]) {
        UserHandler.getAllApps(param: param) { [self] (successResponse) in
            if successResponse.message == "Success"{
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
extension getAllAppsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "getDetailViewController")as! getDetailViewController
        let objData = dataArray[indexPath.row]
        if let appName = objData.appName {
            vc.name = appName
        }
        if let appId = objData.appId {
            vc.appId = appId
        }
        navigationController?.pushViewController(vc, animated: true)
//
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllAppsCell.className, for: indexPath) as! AllAppsCell
      
        let objData = dataArray[indexPath.row]
        
        if let appName = objData.appName {
            cell.appName.text = appName
        }
//
        if let appId = objData.appId {
            cell.appId.text = appId
        }

        if let appTimeStamp = objData.timestamp{
            cell.appTimeStamp.text = (appTimeStamp as NSNumber).stringValue
        }
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
    var appDelegate : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sceneDelegate: SceneDelegate {
        return UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    }
}
