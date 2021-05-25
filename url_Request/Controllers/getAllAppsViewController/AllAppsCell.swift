//
//  AllAppsCell.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class AllAppsCell: UITableViewCell {
    //MARK:-IBOutets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appId: UILabel!
    @IBOutlet weak var appTimeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow()
    }

    
}
