//
//  ListPeopleViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBlocking

class ListPeopleViewController: BaseListViewController {
    
    @IBOutlet fileprivate weak var tableView:UITableView!
    
    var viewModel:ListPeopleViewModel? {
        didSet {
            self.viewModel!.peopleDidChange = { viewModel in
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MVVM"
        
        self.viewModel = ListPeopleViewModel()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.isEditing = editing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddPersonSegue" {
            let navigationViewController = segue.destination as! UINavigationController
            let addPersonViewController = navigationViewController.childViewControllers.first as! AddPersonViewController
            addPersonViewController.delegate = self
        } else {
            let viewController = segue.destination as! ShowPersonViewController
            viewController.viewModel = ShowPersonViewModel(person: self.viewModel!.people[self.tableView.indexPathForSelectedRow!.row])
        }
        
    }
    
}

extension ListPeopleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            self.viewModel!.removePersonAt(IndexPath: indexPath)
            
        default:
            print("ignore any other editing style")
        }
        
    }
    
}

extension ListPeopleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! ListPeopleCell
        //REFACTOR: Should probably not be dealing with the Person model here in the VienController
        // VCs shouldn't know anything about models         
        //cell.person = self.viewModel!.fetchPersonByIndexPath(indexPath)
        
        cell.textLabel!.text = self.viewModel!.nameAndAgeForIndexPath(indexPath)
        
    }

}

extension ListPeopleViewController: AddPersonDelegate {

    func didFinishCreatingPerson(_ person: Person) {
        self.viewModel!.loadPeople()
    }
    
}
