//
//  LoginModelView.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModel, ViewModelType {
    
    
    let userName = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    struct Input{
        let userName: Observable<String>
        let password: Observable<String>
        let login: Observable<Void>
    }
    
    struct Output{
        let validate: Observable<Bool>
        let loginSuccess: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let validate = Observable
            .combineLatest(input.userName, input.password)
            .map{!$0.isEmpty && !$1.isEmpty}
        input.userName.bind(to: userName).disposed(by: disposeBag)
        input.password.bind(to: password).disposed(by: disposeBag)
        
        let request = input.login.flatMapLatest{[weak self] _ -> Observable<UserModel> in
            guard let  `self` = self else { return Observable.empty()}
            let userName = self.userName.value
            let pwd = self.password.value
            return UserAPI.provider.rx
                .request(.login(userName, pwd))
                .mapModel(UserModel.self, path: "data")
                .trackErrorJustComplete(self.error)
                .trackActivity(self.loading)
        }
        .share(replay: 1)
        .do(onNext: {
            user in user.writeToLocal()
        })
        request.bind(to: AppState.share.loginUser).disposed(by: disposeBag)
        let success = request.map{$0.isLogin}
        return Output(
            validate: validate,
            loginSuccess: success
        )
    }
    
}
