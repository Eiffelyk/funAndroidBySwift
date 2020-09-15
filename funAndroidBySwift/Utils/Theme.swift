//
//  Theme.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/4.
//  Copyright © 2020 馋猫. All rights reserved.
//

import UIKit
import RxSwift
import RxTheme

protocol Theme {
    var primaryColor: UIColor{ get }
    var backgroundColor: UIColor{ get }
    var lightBackgroundColor: UIColor{ get }
    var textColor: UIColor{ get }
    var subTextColor: UIColor{ get }
}

struct LightTheme: Theme {
    let primaryColor: UIColor = UIColor.fromHex(0x52b6f4)
    let backgroundColor: UIColor = UIColor.fromHex(0xf0f0f0)
    let lightBackgroundColor: UIColor = UIColor.white
    let textColor: UIColor = UIColor.black
    let subTextColor: UIColor = UIColor.gray
}

struct DarkTheme: Theme {
    let primaryColor: UIColor = UIColor.fromHex(0x52b6f4)
    let backgroundColor: UIColor = UIColor.fromRGBA(42, 42, 42, 1)
    let lightBackgroundColor: UIColor = UIColor.fromRGBA(60, 63, 65, 1)
    let textColor: UIColor = UIColor.white
    let subTextColor: UIColor = UIColor.gray
}

enum ThemeType: ThemeProvider{
    case light,dark
    var associatedObject: Theme{
        switch self {
        case .light:
            return LightTheme()
        case .dark:
            return DarkTheme()
        }
    }
}

let appTheme = { () -> ThemeService<ThemeType> in
    var type = ThemeType.light
    if #available(iOS 13, *) {
        if UITraitCollection.current.userInterfaceStyle == .dark {
            type = .dark
        }
    }
    return ThemeType.service(initial: type)
}()

extension UIFont{
    class var largeTitle: UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
    class var title: UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    class var subTitle: UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    class var small: UIFont{
        return UIFont.systemFont(ofSize: 13)
    }
}
