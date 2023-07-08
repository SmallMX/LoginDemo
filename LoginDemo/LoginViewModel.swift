//
//  LoginViewModel.swift
//  LoginDemo
//
//  Created by MingXin Liu on 2023/7/8.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let disposeBag = DisposeBag()

    let loginSuccess = PublishSubject<User>()
    let loading = PublishSubject<Bool>()
    
    func requestLogin(account: String, password: String) {
        loading.onNext(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.loading.onNext(false)
            self.loginSuccess.onNext(User(account: account, password: password))
        }
    }
    
}
