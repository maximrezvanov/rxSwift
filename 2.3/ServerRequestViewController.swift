//
//  ServerRequestViewController.swift
//  2.3
//
//  Created by MaximRezvanov on 6/30/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ServerRequestViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
serverRequestPause()
    }
    
    
    func serverRequestPause(){
        searchTextField.rx.text
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }


}
