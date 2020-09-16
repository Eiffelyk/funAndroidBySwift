//
//  ViewModel.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(intput: Input) -> Output
}

class ViewModel {
    let disposeBag = DisposeBag()
    lazy var loading = ActivityIndicator()
    lazy var error = ErrorTracker()
}
