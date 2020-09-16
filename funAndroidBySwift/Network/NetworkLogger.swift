//
//  NetworkLogger.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import Moya
import Result

final class NetworkLogger: PluginType{
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("=============开始==============")
        print("-> url:\(target.baseURL.absoluteString + target.path ) \n")
        switch result {
        case .success(let response):
            if response.statusCode != 200 {
                print("-> data \(response) \n")
            }else {
                if let jsonObj = try? response.mapJSON(){
                    if  let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted) {
                        let string = String(data: jsonData, encoding: .utf8)
                        print("-> data \(string ?? "") \n")
                    }
                }
            }
        case .failure(let moyaErr):
            print("-> error: \(moyaErr) \n")
        }
        print("=============结束==============")
    }
}
