//
//  WatchCell.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 7/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit

class WatchCell: UICollectionViewCell {

    var referenceLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.contentView.backgroundColor = UIColor.blue
        
        self.contentView.addSubview(self.referenceLabel)
        
        var views = ["referenceLabel":referenceLabel]
        
        referenceLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }

    }
    
}
