//
//  MainViewController.swift
//  2.3
//
//  Created by MaximRezvanov on 6/30/20.
//  Copyright © 2020 MaximRezvanov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var deleteNameButton: UIButton!
    @IBOutlet weak var addNewNameButton: UIButton!
    
    var nameContainer = BehaviorRelay<[String]>(value: ["Anton", "Nikita", "Stas", "Andrey", "Tanya", "Marina", "Jesika", "Tamara"])
    
    
    let dispose = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameContainer
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: TableViewCell.self)) { (row, element, cell) in
                cell.nameLabel.text = "\(element)"
                
        }.disposed(by: dispose)
        
    }
    
    
    
    
    @IBAction func deleteFirstName(_ sender: UIButton) {
        self.nameContainer.removeLast("\(nameContainer)")
    }
    
    @IBAction func addNewName(_ sender: UIButton) {
        self.nameContainer.add(element: "XXX")
    }
    
}



extension BehaviorRelay where Element: RangeReplaceableCollection {
    
    func add(element: Element.Element) {
        var array = self.value
        let randomEl = array.randomElement()
        array.insert(randomEl!, at: 0 as! Element.Index)
        self.accept(array)
    }
    
    func removeLast (_ element: Element.Element) {
        var array = self.value
        let countArray = array.count
        if countArray > 0 {
            array.remove(at: array.count - 1 as! Element.Index)
            self.accept(array)
        }
    }
    
}

