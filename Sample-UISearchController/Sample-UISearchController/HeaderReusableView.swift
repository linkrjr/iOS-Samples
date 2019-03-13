//
//  HeaderCell.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 8/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit
import SnapKit

class HeaderReusableView: UICollectionReusableView {

    var label = UILabel()
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.yellow
        self.label.text = "Header"
        self.label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(self.label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().offset(20)
        }
        
    }

}
