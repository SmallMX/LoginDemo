//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by MingXin Liu on 2023/7/8.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var accountRemindLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordRemindLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    let viewModel = LoginViewModel()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        self.bindViewModel()
    }
    
    func bindViewModel() {
        
        let accountValid = accountTextField.rx.text.orEmpty.map { $0.isValidEmail }.share(replay: 1)
        let passwordValid = passwordTextField.rx.text.orEmpty.map { PasswordLevel.calculatePasswordLevel(password: $0) != .weak }.share(replay: 1)
        let isLoginEnabled = Observable.combineLatest(accountValid, passwordValid) { $0 && $1 }.share(replay: 1)
        
        accountValid.bind(to: passwordTextField.rx.isEnabled).disposed(by: disposeBag)
        accountValid.bind(to: accountRemindLabel.rx.isHidden).disposed(by: disposeBag)
        passwordValid.bind(to: passwordRemindLabel.rx.isHidden).disposed(by: disposeBag)
        isLoginEnabled.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.clickLoginButton()
        }).disposed(by: disposeBag)
        
        viewModel.loading.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] (isLoading) in
            if isLoading {
                self?.activityIndicator.startAnimating()
            }else {
                self?.activityIndicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
        
        viewModel.loginSuccess.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] (user) in
            self?.loginSuccess(user: user)
        }).disposed(by: disposeBag)
        
    }
    
    func clickLoginButton() {
        self.view.endEditing(true)
        if let account = self.accountTextField.text, let password = self.passwordTextField.text {
            self.viewModel.requestLogin(account: account, password: password)
        }
    }
    
    func loginSuccess(user: User) {
        print("account:\(user.account)    password\(user.password)")
    }

}
