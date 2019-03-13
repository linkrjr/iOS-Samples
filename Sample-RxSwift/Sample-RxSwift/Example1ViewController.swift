//
//  ViewController.swift
//  Sample-RxSwift
//
//  Created by Ronaldo GomesJr on 1/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Gender {
    case Male, Female
}

struct Person {
    var name:String
    var gender:Gender
}

class Example1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView:UITableView!
    @IBOutlet var allButton:UIBarButtonItem!
    @IBOutlet var maleButton:UIBarButtonItem!
    @IBOutlet var femaleButton:UIBarButtonItem!
    
    var content:[Person] = []
    var filteredContent:[Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var a = Variable(1)
        var b = Variable(0)
        var c = Observable.combineLatest(a.asObservable(), b.asObservable()) { $0 + $1 }
                            .filter { $0 >= 0 }
                            .map { "\($0) is positive" }
        
        c.subscribe(onNext: { i -> Void in
            print(i)
        })
        
        a.value = 4
        b.value = -8
        b.value = 18
        
        self.content = [
            Person(name: "Ronaldo", gender: .Male),
            Person(name: "Lach", gender: .Male),
            Person(name: "Karyb", gender: .Female),
            Person(name: "Mark", gender: .Male),
            Person(name: "Ian", gender: .Male),
            Person(name: "Seb", gender: .Male)
        ]
        self.filteredContent = self.content
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.maleButton.rx_tap.map({
            self.filterContent(.Male)
        }) .subscribe { (event) -> Void in
            self.tableView.reloadData()
        }

        self.femaleButton.rx_tap.map({
            self.filterContent(.Female)
        }) .subscribe { (event) -> Void in
            self.tableView.reloadData()
        }

        self.allButton.rx_tap.map({
            self.filterContent()
        }) .subscribe { (event) -> Void in
            self.tableView.reloadData()
        }
        
        
//        let scheduler = MainScheduler.instance
//        
//        let observer = Observable<Int>.interval(0.3, scheduler: scheduler).subscribe { (event) -> Void in
//            print(event)
//        }
//        
//        NSThread.sleepForTimeInterval(2)

        let seq = [1,2,3,4]
        
        let obs = seq.toObservable()
        
//        obs.takeUntil(self.rx_deallocated).subscribe {
//            print($0)
//        }
        
        let s = obs.take(2).map { (s:Int) -> String in
            return "Value: \(s)"
        }.subscribe { (event) -> Void in
            print(event)
        }
        
//        observer.addDisposableTo(DisposeBag())
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredContent.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.filteredContent[indexPath.row].name
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    private func filterContent(gender:Gender? = nil) {
        if let g = gender {
            self.filteredContent = self.content.filter({ p -> Bool in
                return p.gender == g
            })
        } else {
            self.filteredContent = self.content
        }
    }
    
}

