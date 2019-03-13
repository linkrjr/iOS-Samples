//
//  ViewController.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 6/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit

enum SupplementaryViewKind:String {
    case Header = "Header"
    case Section = "Section"
}

//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

//    private var tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    private var collectionView:UICollectionView!
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchBar = UISearchBar()
    
    private var originalData:[Watch]!
    private var data:[Watch]!

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.originalData = GlobalDatabase.sharedInstance.watches
        self.originalData = [Watch(reference: "one"), Watch(reference: "two"), Watch(reference: "three"), Watch(reference: "four")]
        self.data = self.originalData

        self.searchController.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        //        self.searchController.searchBar.scopeButtonTitles = ["Country", "Capital"]
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.sizeToFit()
//        self.addChildViewController(self.searchController)
//        self.view.addSubview(self.searchController.searchBar)
//        self.searchController.didMoveToParentViewController(self)
        
        self.searchBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.searchBar.searchBarStyle = UISearchBarStyle.Default
        self.searchBar.placeholder = "Search"
        self.searchBar.delegate = self
        self.view.addSubview(self.searchBar)
        
        var collectionFlowLayout = CustomCollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: collectionFlowLayout)
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(WatchCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.registerClass(HeaderReusableView.self, forSupplementaryViewOfKind: SupplementaryViewKind.Header.rawValue, withReuseIdentifier: SupplementaryViewKind.Header.rawValue)
        self.collectionView.registerClass(SectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: SupplementaryViewKind.Section.rawValue)
        self.view.addSubview(self.collectionView)

        
        //        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //        self.view.addSubview(self.tableView)
        //        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        //        self.tableView.delegate = self
        //        self.tableView.dataSource = self
        //        var views = ["tableView":self.tableView]

        var views = ["collectionView":self.collectionView, "searchBar": self.searchBar]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[searchBar]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[searchBar][collectionView]|", options: nil, metrics: nil, views: views))
        
        self.definesPresentationContext = true
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let watch = self.data[indexPath.row] as Watch
        println(watch.reference)
        cell.textLabel?.text = watch.reference
        return cell
    }

//MARK: SearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var filterString = searchController.searchBar.text
        self.data = self.originalData
        if !filterString.isEmpty {
            self.data = self.data.filter({
                var value = $0 as Watch
                var found = value.reference.rangeOfString(filterString)
                return (found != nil)
            })
        }
//        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
    
//MARK: CollectionViewDatasource and CollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as WatchCell
        var watch = self.data[indexPath.row] as Watch
        cell.referenceLabel.text = watch.reference
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var supplementaryView:UICollectionReusableView
        switch kind {
        case UICollectionElementKindSectionHeader:
            supplementaryView = self.collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: SupplementaryViewKind.Section.rawValue, forIndexPath: indexPath) as SectionReusableView
        case SupplementaryViewKind.Header.rawValue:
            supplementaryView = self.collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: SupplementaryViewKind.Header.rawValue, forIndexPath: indexPath) as HeaderReusableView
        default:
            supplementaryView = self.collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Unknown", forIndexPath: indexPath) as UICollectionReusableView
        }
        return supplementaryView
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(100.0, 60.0)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        UIApplication.sharedApplication().statusBarOrientation
//        if (UIDeviceOrientationIsLandscape()) {
//            return CGSizeMake(170.f, 170.f)
//        }
//        return CGSizeMake(192.f, 192.f)
//    }
    
//MARK: UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.setShowsCancelButton(false, animated: true)
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println(searchText)
    }
    
}

