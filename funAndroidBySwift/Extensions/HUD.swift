//
//  HUD.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/15.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import MBProgressHUD
import MBProgressHUD_Add

extension MBProgressHUD{
    private struct AssociatedKeys {
        static var isAutoHiddenKey = "MBProgressHUD.isAutoHidden"
    }
    var isAutoHidden: Bool?{
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isAutoHiddenKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isAutoHiddenKey) as? Bool
        }
    }
}

extension UIViewController{
    func showSuccess(msg: String) -> Void {
        let image = Iconfont.success.image(size: 28,color: .white)
        showHUD(with: image, message: msg)
        hud?.isAutoHidden = true
    }
    func showError(msg: String) -> Void {
        let image = Iconfont.error.image(size: 28, color: .white)
        showHUD(with: image, message: msg)
        hud?.isAutoHidden = true
    }
    func showMessage(msg: String) -> Void {
        showHUDMessage(msg)
        hud?.isAutoHidden = true
    }
}
