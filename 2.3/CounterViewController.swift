//
//  CounterViewController.swift
//  2.3
//
//  Created by MaximRezvanov on 7/1/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var changeValueButton: UIButton!
        
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeValueButton.rx.tap
            .scan(0) {(priorValue, _) in
                return priorValue + 1
        }
        .asDriver(onErrorJustReturn: 0)
        .map { currentCount in
            return "\(currentCount)"
        }
        .drive(self.counterLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        
    }
    
    
}
