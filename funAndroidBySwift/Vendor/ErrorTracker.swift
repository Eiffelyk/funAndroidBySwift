//
//  ErrorTracker.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/16.
//  Copyright © 2020 馋猫. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ErrorTracker: SharedSequenceConvertibleType{
    typealias SharingStrategy  = DriverSharingStrategy
    private let _subject = PublishSubject<Error>()
    
    func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: onError)
    }
    
    func asSharedSequence() -> SharedSequence<SharingStrategy,Error> {
        return _subject.asObservable().asDriverOnErrorJustCOmplete()
    }
    func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }
    private func onError(_ error: Error){
        _subject.onNext(error)
    }
}


extension ObservableConvertibleType{
    func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
    
    func trackErrorJustReTurn(_ errorTracker: ErrorTracker, value: Element) -> Observable<Element> {
        return errorTracker.trackError(from: self).catchErrorJustReturn(value)
    }
    
    func trackErrorJustComplete(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self).catchErrorJustComplete()
    }
}
