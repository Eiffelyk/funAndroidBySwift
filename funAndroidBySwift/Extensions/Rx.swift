//
//  Rx.swift
//  funAndroidBySwift
//
//  Created by 馋猫 on 2020/9/15.
//  Copyright © 2020 馋猫. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UINavigationBar{
    var barBackgroundColor: Binder<UIColor?> {
        return Binder<UIColor?>(self.base){
            (bar,color) in
            let bgColor = color ?? .white
            let bgImage = bgColor.mapImage
            bar.setBackgroundImage(bgImage, for: .default)
        }
    }
    var titleColor: Binder<UIColor?> {
        return Binder<UIColor?>(self.base){ (bar,color) in
            bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: color ?? .black]
        }
    }
}

extension ObservableType{
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { (_) -> Observable<Element> in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustCOmplete() -> Driver<Element> {
        return asDriver{ error in
            return Driver.empty()
        }
    }
    func filterNil<E>() -> Observable<E> where Element == E? {
        return self.filter{ $0 != nil }.map{$0!}
    }
}
