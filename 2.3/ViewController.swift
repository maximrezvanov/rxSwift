//
//  ViewController.swift
//  2.3
//
//  Created by MaximRezvanov on 6/21/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class ViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    private let disposeBag = DisposeBag()
    let loginViewModel = LogViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allValid()
        testValid()
    }
    
    func allValid (){
        loginViewModel.isValid().bind(to: buttonOutlet.rx.isEnabled).disposed(by: disposeBag)
        loginViewModel.isValid().map{ $0 ? 1: 0.1} .bind(to: buttonOutlet.rx.alpha).disposed(by: disposeBag)
    }
    func testValid() {
        
        loginTF.rx.text.map{$0 ?? ""}
            .bind(to: loginViewModel.userNamePublishSubject)
            .disposed(by: disposeBag)
        
        passwordTF.rx.text.map{$0 ?? ""}
            .bind(to: loginViewModel.passwordPublishSubject)
            .disposed(by: disposeBag)
        
        loginTF.rx.text.map{ $0!.isValidEmail || $0!.count < 4 ? "": "Invalid e-mail" }.bind(to: (label.rx.text)).disposed(by: disposeBag)
        passwordTF.rx.text.map{ $0!.isEmpty || $0!.count > 5 ? "": "weak password" }.bind(to: (label.rx.text)).disposed(by: disposeBag)
    }
    
    
}

class LogViewModel {
    
    let userNamePublishSubject = PublishSubject<String>()
    let passwordPublishSubject = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        return Observable.combineLatest(userNamePublishSubject.asObservable(), passwordPublishSubject.asObservable()).map{username, password in
            return username.isValidEmail && password.count > 5
            
        }
    }
    
}


extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
