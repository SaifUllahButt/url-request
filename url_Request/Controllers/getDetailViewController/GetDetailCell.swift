//
//  GetDetailCell.swift
//  url_Request
//
//  Created by Zaryab on 5/17/21.
//  Copyright © 2021 M Zaryab. All rights reserved.
//

import UIKit

class GetDetailCell: UITableViewCell {
    //MARK:- IBOutlet
    @IBOutlet weak var platform: UILabel!
    @IBOutlet weak var environment: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var buildNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addShadow()
    }
    //MARK:- Methods
    
}
