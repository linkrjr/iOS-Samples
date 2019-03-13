//
//  CustomCollectionViewFlowLayout.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 9/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
   
    override func prepareLayout() {
        super.prepareLayout()
        self.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.minimumLineSpacing = 1.0
        self.minimumInteritemSpacing = 10.0
        println(self.collectionViewContentSize())
        self.itemSize = CGSizeMake(self.collectionViewContentSize().width, 70.0)
//        self.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var layoutAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)

        layoutAttributes.size = CGSizeMake(40.0, 40.0)
        
        return layoutAttributes
    }
    
}
