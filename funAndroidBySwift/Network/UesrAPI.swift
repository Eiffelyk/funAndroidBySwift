//
//  UesrAPI.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import Moya

enum UserAPI{
    case collectArticle(Int)
    case login(String,String)
    case register(String,String,String)
    case logout
    case coinInfos
}

extension UserAPI: TargetType{
    var path: String{
        switch self {
        case .collectArticle(let id):
            return "/lg/collect/\(id)/json"
        case .login(_, _):
            return "/user/login"
        case .register(_ , _, _):
            return "/user/register"
        case .logout:
            return "/user/logout/json"
        case .coinInfos:
            return "/lg/coin/userinfo/json"
        }
    }
    var method: Moya.Method{
        switch self {
        case .collectArticle(_ ), .login(_ , _), .register(_ , _, _):
            return .post
        default:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .login(let userName, let pwd):
            return .requestParameters(parameters: ["username": userName, "password": pwd], encoding: URLEncoding.default)
        case .register(let userName, let pwd, let rePwd):
            return .requestParameters(parameters: ["username": userName, "password": pwd, "repassword": rePwd], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
}

extension UserAPI{
    static let provider = MoyaProvider<UserAPI>(plugins: defaultPlugins)
}
