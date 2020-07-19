//
//  RocketViewController.swift
//  2.3
//
//  Created by MaximRezvanov on 7/13/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RocketViewController: UIViewController {
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    let disposeBag = DisposeBag()
    let textLabel = "Ракета запущена"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let f = Observable.combineLatest(firstButton.rx.tap, secondButton.rx.tap)
        f.subscribe(onNext: { _ in
            self.label.text = self.textLabel
        }).disposed(by: disposeBag)
    }
    
    
    
   
    
    
    
}
