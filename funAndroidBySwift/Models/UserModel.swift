//
//  UserModel.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/3.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import HandyJSON

class UserModel:HandyJSON {
    var admin = false
    var chapterTops: [Int]?
    var collectIds: [Int]?
    var email: String?
    var icon: String?
    var id: Int?
    var nickname: String?
    var password: String?
    var pulicName: String?
    var token: String?
    var type: Int?
    var username: String?
    var coinCount = 0
    var rank = 0
    
    required init() {
    }
}

extension UserModel{
    var isLogin: Bool{
        return id != nil
    }
    var displayName: String?{
        return nickname ?? username
    }
}

extension UserModel{
    class var cachePath:String {
        return "user/login"
    }
    func writeToLocal() -> Void {
        guard
            let json = toJSONString(),
            let data = json.data(using: .utf8)
        else { return }
        FileUtils.write(data: data, to: UserModel.cachePath)
    }
    class func fromLocal() -> UserModel? {
        if let data = FileUtils.readData(from: UserModel.cachePath) {
            let dataStr = String(data: data, encoding: .utf8)
            let user = UserModel.deserialize(from: dataStr)
            return user
        }
        return nil
    }
}
