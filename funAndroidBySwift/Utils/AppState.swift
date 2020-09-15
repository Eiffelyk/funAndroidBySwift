//
//  AppState.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/3.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppState {
    static let share = AppState()
    let loginUser = BehaviorRelay<UserModel>(value: UserModel())
}

extension AppState{
    func setup() -> Void {
        DispatchQueue.main.async {
            if let user = UserModel.fromLocal(){
                self.loginUser.accept(user)
            }
        }
    }
}
