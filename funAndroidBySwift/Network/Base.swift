//
//  Base.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import Moya

extension TargetType{
    var baseURL: URL {
        return URL(string: "https://www.wanandroid.com")!
    }
    var method: Moya.Method{
        return .get
    }
    var sampleData:Data{
        return Data()
    }
    var tast: Task{
        return .requestPlain
    }
    var headers:[String: String]?{
        return nil
    }
}

let defaultPlugins = { () -> [PluginType] in
       #if DEBUG
       return [NetworkLogger()]
       #else
       return []
       #endif
}()
