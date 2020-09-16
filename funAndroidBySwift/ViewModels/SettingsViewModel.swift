//
//  SettingsViewModel.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SettingsViewModel: ViewModel,ViewModelType {
    struct Input {
        let switchTheme: Observable<Bool>
        var logout: Observable<Void>?
    }
    struct Output {
        var logoutSuccess: Observable<Void>?
    }
    func transform(intput: Input) -> Output {
        intput.switchTheme
            .map{$0 ? ThemeType.dark : ThemeType.light}
            .bind(to: appTheme.switcher)
            .disposed(by: disposeBag)
        var logoutSuccess: Observable<Void>?
        if let logout = intput.logout{
            logoutSuccess = logout.flatMapLatest{(_) -> Observable<Void> in
                return UserAPI.provider.rx
                    .request(.logout)
                    .validateSucess()
                    .trackErrorJustComplete(self.error)
                    .trackActivity(self.loading)
            }
            .do(onNext:{
                let emptyUser = UserModel()
                emptyUser.writeToLocal()
                AppState.share.loginUser.accept(emptyUser)
            })
        }
        return Output(
            logoutSuccess: logoutSuccess
        )
    }
}
