//
//  getAllAppsViewController.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class getAllAppsViewController: UIViewController { // swiftlint:disable:this type_name
    // MARK:-... 'Properties'
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: AllAppsCell.className, bundle: nil), forCellReuseIdentifier: AllAppsCell.className)
        }
    }
    // MARK:- Properties
    var dataArray = [AllAppsData]()
    
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data : [String : AnyObject] = [:]
        getAllApps(param: data)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
// MARK:- Methods
    @objc func pullToRefresh() {
        print("refreshing start")
        DispatchQueue.main.asyncAfter(deadline: .now()+1){
            let data: [String: AnyObject] = [:]
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
        }    }
    
  }
// //MARK:- PropertiesMARK:- Extensions
extension getAllAppsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcc = storyboard?.instantiateViewController(identifier: "getDetailViewController")as! getDetailViewController // swiftlint:disable:this force_cast
        let objData = dataArray[indexPath.row]
        if let appName = objData.appName {
            vcc.name = appName
        }
        if let appId = objData.appId {
            vcc.appId = appId
        }
        navigationController?.pushViewController(vcc, animated: true)
//
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllAppsCell.className, for: indexPath) as! AllAppsCell // swiftlint:disable:this force_cast // swiftlint:disable:this line_length
        let objData = dataArray[indexPath.row]
        if let appName = objData.appName {
            cell.appName.text = appName
        }
//
        if let appId = objData.appId {
            cell.appId.text = appId
        }

        if let appTimeStamp = objData.timestamp {

            let myDate = NSDate(timeIntervalSince1970: TimeInterval(appTimeStamp))
//            cell.appTimeStamp.text = (myDate as NSNumber).stringValue
            let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yy"
            let formatteddate = formatter.string(from: myDate as Date)
            cell.appTimeStamp.text = formatteddate
        }
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.size.height/7
//    }

}
extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
    }
    var sceneDelegate: SceneDelegate {
        return UIApplication.shared.connectedScenes.first?.delegate as! // swiftlint:disable:this force_cast
            SceneDelegate
    }
}
