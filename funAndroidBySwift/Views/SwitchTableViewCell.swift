//
//  SwitchTableViewCell.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    var `switch` : UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = self.switch
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has no been implemented")
    }
}
