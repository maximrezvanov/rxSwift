//
//  ExampleRetainCircleViewController.swift
//  2.3
//
//  Created by MaximRezvanov on 7/15/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExampleRetainCircleViewController: UIViewController {
     @IBOutlet weak var addSomthing: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSomthing.rx.tap.subscribe (onNext: { _ in
            self.doStuff()
        })
        
        self.addSomthing.rx.tap
        .map(self.doStuff)
        .subscribe(onNext: { (_) in
            print("done")
        })

    }
    

  func doStuff() {
         print("retain circle")
     }

}
