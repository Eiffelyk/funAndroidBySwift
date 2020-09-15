//
//  UIImage+Iconfont.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/3.
//  Copyright © 2020 馋猫. All rights reserved.
//

import UIKit

extension UIImage{
    class func fromIconfont(content: String,
                            size: CGFloat,
                            fontName:String,
                            color: UIColor = .black,
                            backgroundColor: UIColor = .clear
    ) -> UIImage {
        let drawSize = CGSize(width: size, height: size)
        UIGraphicsBeginImageContextWithOptions(drawSize, false, UIScreen.main.scale)
        let rect = CGRect(origin: .zero, size: drawSize)
        let path = UIBezierPath(rect: rect)
        backgroundColor.setFill()
        path.fill()
        color.setFill()
        
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        
        let string = content as NSString
        string.draw(in: rect, withAttributes: [
                                               NSAttributedString.Key.font: UIFont(name: fontName, size: size)!,
                                               NSAttributedString.Key.backgroundColor: backgroundColor,
                                               NSAttributedString.Key.foregroundColor: color,
                                               NSAttributedString.Key.paragraphStyle: style
        ])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
