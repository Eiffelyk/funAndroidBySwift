//
//  UIViewController.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/15.
//  Copyright © 2020 馋猫. All rights reserved.
//

import UIKit

extension UIViewController{
    class func fromStoryboard(name: String? = nil, identifier: String? = nil)-> Self? {
        let selfName = String(describing: self)
        let storyboard = UIStoryboard(name: name ?? selfName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier ?? selfName)
        return viewController as? Self
    }
}
