//
//  SectionReusableView.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 9/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit

class SectionReusableView: UICollectionReusableView {

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
        
        self.backgroundColor = UIColor.green
        self.label.text = "Section"

        addSubview(self.label)
        var views = ["label":label]
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview().offset(20)
        }
        
    }
    
}
